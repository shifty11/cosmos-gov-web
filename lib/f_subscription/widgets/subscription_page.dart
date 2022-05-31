import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pb.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_home/widgets/bottom_navigation_bar_widget.dart';
import 'package:cosmos_gov_web/f_subscription/services/message_provider.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_provider.dart';
import 'package:cosmos_gov_web/f_subscription/services/type/subscription_data_type.dart';
import 'package:cosmos_gov_web/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riverpod_messages/riverpod_messages.dart';
import 'package:tuple/tuple.dart';

class SubscriptionPage extends StatelessWidget {
  final double sideBarWith = 0;

  const SubscriptionPage({Key? key}) : super(key: key);

  int getCrossAxisCount(BuildContext context) {
    if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 1;
    }
    if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 3;
    }
    return 4;
  }

  Widget subscriptionsLoaded(BuildContext context, ChatroomData chatRoom) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(context),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 50,
      ),
      itemCount: chatRoom.filtered.length,
      itemBuilder: (BuildContext context, int index) {
        return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final data = Tuple2(chatRoom.chatRoomId, chatRoom.getUnfilteredIndex(index));
          final state = ref.watch(subscriptionStateProvider(data));
          const double sidePadding = 12;
          return state.when(
            loaded: (subscription) => Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: Styles.selectCardBorderWith,
                    color: Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: InkWell(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.focusedChild?.unfocus();
                  }
                  ref.read(subscriptionStateProvider(data).notifier).toggleSubscription();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: sidePadding),
                      child: Text(
                        subscription.displayName,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    subscription.isSubscribed
                        ? const Padding(
                            padding: EdgeInsets.only(right: sidePadding),
                            child: Icon(Icons.check_circle_rounded, color: Styles.enabledColor, size: 24),
                          )
                        : const SizedBox(width: 24),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget subscriptionList() {
    return Expanded(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final state = ref.watch(chatroomListStateProvider);
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (chatRooms) => subscriptionsLoaded(context, ref.watch(searchedSubsProvider)),
            error: (err, stackTrace) => Container(),
          );
        },
      ),
    );
  }

  Widget searchWidget(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return TextField(
        onChanged: (value) => ref.watch(searchSubsProvider.notifier).state = value,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          hintText: "Search",
        ),
      );
    });
  }

  Widget chatDropdownWidget(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final state = ref.watch(chatroomListStateProvider);
      return state.when(
        loading: () => Container(),
        data: (chatRooms) {
          if (chatRooms.isEmpty) {
            return Container();
          }
          if (chatRooms.length == 1) {
            return Text(chatRooms.first.name);
          }
          return DropdownButton<ChatRoom>(
            value: ref.watch(chatRoomProvider) ?? chatRooms.first,
            icon: const Icon(Icons.person),
            onChanged: (ChatRoom? newValue) {
              ref.watch(chatRoomProvider.notifier).state = newValue;
            },
            items: chatRooms.map<DropdownMenuItem<ChatRoom>>((ChatRoom chatRoom) {
              return DropdownMenuItem<ChatRoom>(
                value: chatRoom,
                child: Text(chatRoom.name),
              );
            }).toList(),
          );
        },
        error: (err, stackTrace) => Container(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          MessageOverlayListener(
            provider: subsMsgProvider,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Subscriptions", style: Theme.of(context).textTheme.headline2),
                  chatDropdownWidget(context),
                  const SizedBox(height: 10),
                  const Text("Select the projects that you want to follow. You will receive notifications about new governance proposals once they enter the voting period."),
                  const SizedBox(height: 20),
                  searchWidget(context),
                  const SizedBox(height: 20),
                  subscriptionList(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(jwtManager: jwtManager),
    );
  }
}

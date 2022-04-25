import 'dart:math';

import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pb.dart';
import 'package:cosmos_gov_web/f_home/widgets/sidebar_widget.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_provider.dart';
import 'package:cosmos_gov_web/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tuple/tuple.dart';

class SubscriptionPage extends StatelessWidget {
  final double sideBarWith = 300;

  const SubscriptionPage({Key? key}) : super(key: key);

  int getCrossAxisCount(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 800) {
      return 2;
    } else if (MediaQuery.of(context).size.width <= 1000) {
      return 3;
    } else {
      return 4;
    }
  }

  Widget subscriptionWidget(BuildContext context, ChatRoom chatRoom) {
    return SizedBox(
      height: 600,
      width: ResponsiveWrapper.of(context).isLargerThan(TABLET) ? 1100 - sideBarWith : null,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(context),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 50,
        ),
        itemCount: chatRoom.subscriptions.length,
        itemBuilder: (BuildContext context, int index) {
          return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final data = Tuple2(chatRoom.subscriptions[index], chatRoom.id);
            final state = ref.watch(subscriptionStateProvider(data));
            const double sidePadding = 12;
            return state.when(
              loaded: (subscription) => Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: subscription.isSubscribed ? Colors.green : grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: InkWell(
                  onTap: () {
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
                              child: Icon(Icons.check_circle_rounded, color: Colors.green, size: 24),
                            )
                          : const SizedBox(width: 24),
                    ],
                  ),
                ),
              ),
              error: (err) => ErrorWidget(err.toString()),
            );
          });
        },
      ),
    );
  }

  Widget searchWidget(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return TextField(
          onChanged: (value) => ref.watch(searchProvider.notifier).state = value,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
            hintText: "Search",
          ),
        );
      }),
    );
  }

  Widget chatDropdownWidget(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final state = ref.watch(chatroomListStateProvider);
        return state.when(
          loading: () => Container(),
          loaded: (chatRooms) {
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
                print("new state");
                print(newValue);
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
          error: (err) => ErrorWidget(err.toString()),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    double margin = max((MediaQuery.of(context).size.width - 1200) / 2, 0);
    return Scaffold(
      body: Row(
        children: [
          const SidebarWidget(),
          Container(
            width: 800, // TODO fix width
            padding: const EdgeInsets.all(40),
            // margin: EdgeInsets.symmetric(horizontal: margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Subscriptions", style: Theme.of(context).textTheme.headline2),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      searchWidget(context),
                      const Spacer(flex: 20),
                      chatDropdownWidget(context),
                    ],
                  ),
                ),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    final state = ref.watch(chatroomListStateProvider);
                    return state.when(
                      loading: () => const CircularProgressIndicator(),
                      loaded: (chatRooms) => subscriptionWidget(context, ref.watch(searchedSubsProvider)),
                      error: (err) => ErrorWidget(err.toString()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

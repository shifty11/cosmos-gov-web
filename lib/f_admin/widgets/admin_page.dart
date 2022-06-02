import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_admin/services/admin_provider.dart';
import 'package:cosmos_gov_web/f_admin/services/message_provider.dart';
import 'package:cosmos_gov_web/f_home/widgets/bottom_navigation_bar_widget.dart';
import 'package:cosmos_gov_web/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:riverpod_messages/riverpod_messages.dart';

class AdminPage extends StatelessWidget {
  final double sideBarWith = 0;

  const AdminPage({Key? key}) : super(key: key);

  int getCrossAxisCount(BuildContext context) {
    if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 1;
    }
    if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 2;
    }
    return 3;
  }

  Widget chainsLoaded(BuildContext context, WidgetRef ref) {
    const double sidePadding = 12;
    const double iconSize = 24;
    final disabledColor = Theme.of(context).unselectedWidgetColor;
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(context),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 50,
      ),
      itemCount: ref.watch(searchedChainProvider).length,
      itemBuilder: (BuildContext context, int arrayIndex) {
        return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final index = ref.read(searchedChainProvider)[arrayIndex];
          final chainNotifier = ref.read(chainStateProvider(index).notifier);
          final state = ref.watch(chainStateProvider(index));
          return state.when(
            loaded: (chain) => Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: Styles.selectCardBorderWith,
                    color: disabledColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: InkWell(
                onTap: () {
                  chainNotifier.setEnabled();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: sidePadding),
                      child: Text(
                        chain.displayName,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const Spacer(),
                    chain.isEnabled
                        ? IconButton(
                            icon: const Icon(Icons.how_to_vote),
                            color: chain.isVotingEnabled ? Theme.of(context).primaryColor : disabledColor,
                            iconSize: iconSize,
                            padding: const EdgeInsets.symmetric(horizontal: sidePadding),
                            tooltip: chain.isVotingEnabled ? "Voting is enabled" : "Voting is disabled",
                            onPressed: () => chainNotifier.setVotingEnabled(),
                          )
                        : Container(),
                    chain.isEnabled
                        ? IconButton(
                            icon: const Icon(Icons.paid),
                            color: chain.isFeegrantUsed ? Theme.of(context).primaryColor : disabledColor,
                            iconSize: iconSize,
                            padding: const EdgeInsets.only(right: sidePadding),
                            tooltip: chain.isFeegrantUsed ? "User will pay the fees for votes" : "Bot will pay the fees for votes",
                            onPressed: () => chainNotifier.setFeegrantUsed(),
                          )
                        : Container(),
                    chain.isEnabled
                        ? Padding(
                            padding: const EdgeInsets.only(right: sidePadding),
                            child: Icon(Icons.check_circle_rounded, color: Theme.of(context).primaryColor, size: iconSize),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget chainList() {
    return Expanded(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final state = ref.watch(chainListStateProvider);
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (chains) => chainsLoaded(context, ref),
            error: (err, stackTrace) => ErrorWidget(err.toString()),
          );
        },
      ),
    );
  }

  Widget searchWidget(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return TextField(
        onChanged: (value) => ref.watch(searchChainProvider.notifier).state = value,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
          hintText: "Search",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          MessageOverlayListener(
            provider: adminMsgProvider,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Admin", style: Theme.of(context).textTheme.headline2),
                  const SizedBox(height: 10),
                  searchWidget(context),
                  const SizedBox(height: 40),
                  chainList(),
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

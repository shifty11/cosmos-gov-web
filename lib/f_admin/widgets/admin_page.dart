import 'package:cosmos_gov_web/api/protobuf/dart/admin_service.pb.dart';
import 'package:cosmos_gov_web/f_admin/services/admin_provider.dart';
import 'package:cosmos_gov_web/f_home/widgets/bottom_navigation_bar_widget.dart';
import 'package:cosmos_gov_web/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AdminPage extends StatelessWidget {
  final double sideBarWith = 0;

  const AdminPage({Key? key}) : super(key: key);

  int getCrossAxisCount(BuildContext context) {
    if (ResponsiveWrapper.of(context).isSmallerThan(TABLET)) {
      return 1;
    }
    if (ResponsiveWrapper.of(context).isSmallerThan(DESKTOP)) {
      return 3;
    }
    return 4;
  }

  Widget chainsLoaded(BuildContext context, List<ChainSettings> chains) {
    const double sidePadding = 12;
    const double iconSize = 24;
    final disabledColor = Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color;
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(context),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 50,
      ),
      itemCount: chains.length,
      itemBuilder: (BuildContext context, int index) {
        return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final state = ref.watch(chainStateProvider(index));
          return state.when(
            loaded: (chain) => Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    width: Styles.selectCardBorderWith,
                    color: chain.isEnabled ? Styles.enabledColor : disabledColor,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              child: InkWell(
                onTap: () {
                  // if (!chain.isEnabled) {
                  ref.read(chainStateProvider(index).notifier).setEnabled();
                  // }
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
                            color: chain.isVotingEnabled ? Styles.enabledColor : disabledColor,
                            iconSize: iconSize,
                            padding: const EdgeInsets.symmetric(horizontal: sidePadding),
                            onPressed: () => ref.read(chainStateProvider(index).notifier).setVotingEnabled(),
                          )
                        : Container(),
                    chain.isEnabled
                        ? IconButton(
                            icon: const Icon(Icons.paid),
                            color: chain.isFeegrantUsed ? Styles.enabledColor : disabledColor,
                            iconSize: iconSize,
                            padding: const EdgeInsets.only(right: sidePadding),
                            onPressed: () => ref.read(chainStateProvider(index).notifier).setFeegrantUsed(),
                          )
                        : Container(),
                    chain.isEnabled
                        ? const Padding(
                            padding: EdgeInsets.only(right: sidePadding),
                            child: Icon(Icons.check_circle_rounded, color: Styles.enabledColor, size: iconSize),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            error: (err) => ErrorWidget(err.toString()),
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
            loading: () => const CircularProgressIndicator(),
            data: (chains) => chainsLoaded(context, ref.watch(searchedChainProvider)),
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
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Admin", style: Theme.of(context).textTheme.headline2),
                searchWidget(context),
                const SizedBox(height: 40),
                chainList(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

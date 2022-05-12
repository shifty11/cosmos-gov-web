import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/f_home/widgets/bottom_navigation_bar_widget.dart';
import 'package:cosmos_gov_web/f_voting/services/chain_list_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/keplr_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/message_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_messages/riverpod_messages.dart';

extension Formatting on VotePermission {
  Widget row() {
    var date = DateTime.fromMillisecondsSinceEpoch(expiresAt.seconds.toInt() * 1000);
    var df = DateFormat('dd-MM-yyyy (HH:mm:ss)').format(date);
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(chain.displayName),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("${granter.substring(0, chain.accountPrefix.length + 3)}...${granter.substring(granter.length - 5, granter.length)}"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(df),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ElevatedButton(
              onPressed: () async {
                final keplr = ref.watch(keplrTxProvider.notifier);
                await keplr.revokeVotePermission(this);
              },
              child: const Text("Revoke"),
            );
          },
        ),
      ],
    );
  }
}

class VotingPage extends StatelessWidget {
  final double sidePadding = 40;

  const VotingPage({Key? key}) : super(key: key);
  
  Widget votePermissionsLoaded(BuildContext context, List<VotePermission> votePermissions) {
    List<Widget> rows = [];
    for (var vp in votePermissions) {
      rows.add(vp.row());
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 2 * sidePadding),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: rows,
      ),
    );
  }

  Widget chainDropdownWidget(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final state = ref.watch(chainListStateProvider);
      return state.when(
        loading: () => Container(),
        data: (chains) {
          if (chains.isEmpty) {
            return Container();
          }
          return DropdownButton<Chain>(
            value: ref.watch(selectedChainProvider),
            // icon: const Icon(Icons.person),
            onChanged: (Chain? newValue) {
              ref.watch(selectedChainProvider.notifier).state = newValue;
            },
            items: chains.map<DropdownMenuItem<Chain>>((Chain chain) {
              return DropdownMenuItem<Chain>(
                value: chain,
                child: Text(chain.displayName),
              );
            }).toList(),
          );
        },
        error: (err, stackTrace) => Container(),
      );
    });
  }

  Widget addGrantWidget(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final keplrState = ref.watch(keplrTxProvider);
      return Padding(
        padding: const EdgeInsets.only(left: 40),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 48),
          ),
          child: keplrState.whenOrNull(
                  executing: (chain) => CircularProgressIndicator(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      )) ??
              const Text("Add Vote Permission"),
          onPressed: () async {
            final chain = ref.watch(selectedChainProvider);
            print(chain);
            if (chain == null) {
              return;
            }

            final keplr = ref.watch(keplrTxProvider.notifier);
            final address = await keplr.getAddress(chain.chainId);
            final int secondsSinceEpoch = DateTime.now().toUtc().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
            final expiration = secondsSinceEpoch + 7 * 24 * 60 * 60;

            final vp = VotePermission(chain: chain, granter: address);

            await keplr.grantVotePermission(vp, expiration);
          },
        ),
      );
    });
  }

  Widget votePermissionList() {
    return Expanded(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final state = ref.watch(votePermissionListStateProvider);
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (votePermissions) => votePermissionsLoaded(context, votePermissions),
            error: (err) => Container(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(sidePadding),
        child: MessageOverlayListener(
          provider: votingMsgProvider,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Voting", style: Theme.of(context).textTheme.headline2),
              votePermissionList(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  chainDropdownWidget(context),
                  addGrantWidget(context),
                  const Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

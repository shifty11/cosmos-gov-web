import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/f_home/widgets/sidebar_widget.dart';
import 'package:cosmos_gov_web/f_voting/services/chain_list_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/keplr_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class VotingPage extends StatelessWidget {
  const VotingPage({Key? key}) : super(key: key);

  showPopUp(BuildContext context, String title, String text) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget votePermissionList(BuildContext context, List<VotePermission> votePermissions) {
    List<Widget> rows = [];
    for (var vp in votePermissions) {
      rows.add(vp.row());
    }
    return SizedBox(
      height: 600,
      width: 700,
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
        loaded: (chains) {
          if (chains.isEmpty) {
            return Container();
          }
          return DropdownButton<Chain>(
            value: ref.watch(selectedChainProvider) ?? (chains.isNotEmpty ? chains.first : null),
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
        error: (err) => ErrorWidget(err.toString()),
      );
    });
  }

  Widget addGrantWidget(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return ElevatedButton(
          onPressed: () async {
            final chain = ref.watch(selectedChainProvider);
            if (chain == null) {
              return;
            }

            final keplr = ref.watch(keplrTxProvider.notifier);
            final address = await keplr.getAddress(chain.chainId);
            final int secondsSinceEpoch = DateTime.now().toUtc().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
            final expiration = secondsSinceEpoch + 7 * 24 * 60 * 60;

            final vp = VotePermission(chain: chain, granter: address);

            await keplr.grantVotePermission(vp, expiration);
            // showPopUp(context, result.success ? "Success" : "Failure", result.success ? result.txHash : result.error);
          },
          child: const Text("Add Vote Permission"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SidebarWidget(),
          Container(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Voting", style: Theme.of(context).textTheme.headline2),
                chainDropdownWidget(context),
                addGrantWidget(context),
                Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    final state = ref.watch(votePermissionListStateProvider);
                    return state.when(
                      loading: () => const CircularProgressIndicator(),
                      loaded: (votePermissions) => votePermissionList(context, votePermissions),
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
          child: Text(granter),
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

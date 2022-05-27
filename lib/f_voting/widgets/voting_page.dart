import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_home/widgets/bottom_navigation_bar_widget.dart';
import 'package:cosmos_gov_web/f_voting/services/chain_list_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/keplr_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/message_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_messages/riverpod_messages.dart';

extension Formatting on Wallet {
  DataRow row(WidgetRef ref) {
    var df = "";
    if (votePermissions.isNotEmpty) {
      var date = DateTime.fromMillisecondsSinceEpoch(votePermissions.first.expiresAt.seconds.toInt() * 1000);
      df = DateFormat('dd-MM-yyyy').format(date);
    }
    const double iconSize = 24;
    return DataRow(cells: <DataCell>[
      DataCell(Text(chain.displayName)),
      DataCell(Text("${address.substring(0, 12)}...${address.substring(address.length - 5, address.length)}")),
      DataCell(Text(df)),
      DataCell(Row(
        children: [
          votePermissions.isEmpty ? IconButton(
            icon: const Icon(Icons.add_circle),
            color: Colors.blue,
            iconSize: iconSize,
            tooltip: "Grant vote permission",
            onPressed: () => ref.read(keplrTxProvider.notifier).grantVotePermission(this),
          ) : IconButton(
            icon: const Icon(Icons.cancel),
            color: Colors.orange,
            iconSize: iconSize,
            tooltip: "Revoke vote permission",
            onPressed: () => ref.read(keplrTxProvider.notifier).revokeVotePermission(this),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            iconSize: iconSize,
            tooltip: "Remove wallet",
            onPressed: () => ref.read(keplrTxProvider.notifier).removeWallet(this),
          )
        ],
      )),
    ]);
  }
}

class VotingPage extends StatelessWidget {
  final double sidePadding = 40;

  const VotingPage({Key? key}) : super(key: key);

  Widget walletsLoaded(BuildContext context, List<Wallet> wallets) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      return DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text("Chain", style: TextStyle(fontStyle: FontStyle.italic))),
          DataColumn(label: Text("Address", style: TextStyle(fontStyle: FontStyle.italic))),
          DataColumn(label: Text("Expiry", style: TextStyle(fontStyle: FontStyle.italic))),
          DataColumn(label: Text("Actions", style: TextStyle(fontStyle: FontStyle.italic))),
        ],
        rows: wallets.map((w) => w.row(ref)).toList(),
      );
    });
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

  Widget addWalletWidget(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
      final keplrState = ref.watch(keplrTxProvider);
      return Padding(
        padding: const EdgeInsets.only(left: 40),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 32),
          ),
          child: keplrState.whenOrNull(
                  executing: (chain) => CircularProgressIndicator(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      )) ??
              const Text("Add Wallet"),
          onPressed: () async {
            final chain = ref.watch(selectedChainProvider);
            if (chain == null) {
              return;
            }

            final keplr = ref.watch(keplrTxProvider.notifier);
            await keplr.registerWallet(chain);
          },
        ),
      );
    });
  }

  Widget walletList() {
    return Expanded(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final state = ref.watch(walletListProvider);
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (wallets) => walletsLoaded(context, wallets),
            error: (err, stackTrace) => Container(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  chainDropdownWidget(context),
                  addWalletWidget(context),
                  const Spacer(),
                ],
              ),
              walletList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(jwtManager: jwtManager),
    );
  }
}

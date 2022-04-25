import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/f_home/widgets/sidebar_widget.dart';
import 'package:cosmos_gov_web/f_voting/services/cosmos_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class VotingPage extends StatelessWidget {
  const VotingPage({Key? key}) : super(key: key);

  Widget votePermissionList(BuildContext context, List<VotePermission> votePermissions) {
    List<Widget> rows = [];
    for (var vp in votePermissions) {
      rows.add(vp.row());
    }
    return SizedBox(
      height: 600,
      width: 600,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: rows,
      ),
    );
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
    var df = DateFormat('dd-MM-yyyy').format(date);
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Dig"),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(address),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(df),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return ElevatedButton(
              onPressed: () {
                final cosmos = ref.watch(cosmosProvider);
                final int secondsSinceEpoch = DateTime.now().toUtc().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
                final expiration = secondsSinceEpoch + 7 * 24 * 60 * 60;
                // final grant = cosmos.getGrant("juno1um0j8mskacs58whj3zd3fx6nrytsw8w22cndrd", "juno1wtcvjqx8097gtkjdemle9c0lm8gczm2at2h6j0", expiration);
                const chainId = "osmosis-1";
                const rpcAddress = 'https://rpc-osmosis.blockapsis.com:443';
                cosmos.executeGrant(chainId, rpcAddress, "osmo1um0j8mskacs58whj3zd3fx6nrytsw8w253rxjr",
                    "osmo1wtcvjqx8097gtkjdemle9c0lm8gczm2a4r83rp", expiration);
              },
              child: Text("Grant"),
            );
          },
        ),
      ],
    );
  }
}

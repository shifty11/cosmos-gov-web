import 'package:cosmos_gov_web/f_home/services/auth_provider.dart';
import 'package:cosmos_gov_web/f_subscription/widgets/subscription_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmos Governance',
      home: Column(
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final state = ref.watch(authStatusProvider);
              return state.when(
                loading: () => const CircularProgressIndicator(),
                error: (err) => Text("error: " + err.toString()),
                unauthorized: () => Text("unauthorized"),
                authorized: () => SubscriptionPage(),
              );
            },
          ),
        ],
      ),
    );
  }
}

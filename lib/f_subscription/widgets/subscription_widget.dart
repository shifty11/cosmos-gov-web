import 'package:cosmos_gov_web/f_subscription/services/subscription_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Subscriptions"),
        SizedBox(
          height: 100,
          child: Text("Search"),
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(subscriptionStateProvider);
            return state.when(
              loading: () => const CircularProgressIndicator(),
              loaded: () => Text("loaded"),
              error: (err) => Text("error: " + err.toString()),
            );
          },
        ),
      ],
    );
  }
}

import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pb.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  Widget subscriptionWidget(BuildContext context, List<Subscription> subscriptions) {
    return SizedBox(
      // width: 500,
      height: 800,
      child: GridView.count(
        crossAxisCount: 5,
        children: List.generate(
          subscriptions.length,
          (index) {
            return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final state = ref.watch(subscriptionStateProvider(subscriptions[index]));
              return state.when(
                loaded: (subscription) => Container(
                  color: subscription.isSubscribed ? Colors.green : Colors.amber,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          subscription.displayName,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            ref.read(subscriptionStateProvider(subscriptions[index]).notifier).toggleSubscription();
                          },
                          child: Text("click"))
                    ],
                  ),
                ),
                error: (err) => Text("error: " + err.toString()),
              );
            });
          },
        ),
      ),
    );
  }

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
            final state = ref.watch(subscriptionListStateProvider);
            return state.when(
              loading: () => const CircularProgressIndicator(),
              loaded: (subscriptions) => subscriptionWidget(context, subscriptions),
              error: (err) => Text("error: " + err.toString()),
            );
          },
        ),
      ],
    );
  }
}

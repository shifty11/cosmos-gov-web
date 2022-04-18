import 'dart:math';

import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pb.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_provider.dart';
import 'package:cosmos_gov_web/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SubscriptionPage extends StatelessWidget {
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

  Widget subscriptionWidget(BuildContext context, List<Subscription> subscriptions) {
    return SizedBox(
      height: 600,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: getCrossAxisCount(context),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 50,
        ),
        itemCount: subscriptions.length,
        itemBuilder: (BuildContext context, int index) {
          return Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(subscriptionStateProvider(subscriptions[index]));
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
                    ref.read(subscriptionStateProvider(subscriptions[index]).notifier).toggleSubscription();
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
              error: (err) => Text("error: " + err.toString()),
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

  @override
  Widget build(BuildContext context) {
    double margin = max((MediaQuery.of(context).size.width - 1200) / 2, 0);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(40),
        margin: EdgeInsets.symmetric(horizontal: margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Subscriptions", style: Theme.of(context).primaryTextTheme.headline2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: searchWidget(context),
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                final state = ref.watch(subscriptionListStateProvider);
                return state.when(
                  loading: () => const CircularProgressIndicator(),
                  loaded: (subscriptions) => subscriptionWidget(context, ref.watch(searchedSubsProvider)),
                  error: (err) => Text("error: " + err.toString()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

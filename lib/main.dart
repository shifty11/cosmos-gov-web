import 'package:cosmos_gov_web/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/auth_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cosmos Governance',
      home: Column(
        children: [
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              AuthState state = ref.watch(authStatusProvider);
              return state.when(
                loading: () => Text("loading"),
                error: (err) => Text("error: " + err.toString()),
                unauthorized: () => Text("unauthorized"),
                authorized: () => Text("authorized"),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_home/services/auth_provider.dart';
import 'package:cosmos_gov_web/f_home/services/state/auth_state.dart';
import 'package:cosmos_gov_web/f_home/widgets/loading_page.dart';
import 'package:cosmos_gov_web/f_subscription/widgets/subscription_page.dart';
import 'package:cosmos_gov_web/f_voting/widgets/voting_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<MyRouter>((ref) => MyRouter(ref.watch(authStateValueProvider)));

class MyRouter {
  final ValueNotifier<AuthState> authStateListener;

  MyRouter(this.authStateListener);

  late final router = GoRouter(
    refreshListenable: authStateListener,
    debugLogDiagnostics: kDebugMode,
    urlPathStrategy: UrlPathStrategy.path,
    routes: [
      GoRoute(
        name: rRoot.name,
        path: rRoot.path,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoadingPage(),
        ),
      ),
      GoRoute(
        name: rUnauthorized.name,
        path: rUnauthorized.path,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const Text("login not implemented yet"),
        ),
      ),
      GoRoute(
        name: rSubscriptions.name,
        path: rSubscriptions.path,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const SubscriptionPage(),
        ),
      ),
      GoRoute(
        name: rVoting.name,
        path: rVoting.path,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const VotingPage(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      // child: ErrorPage(error: state.error),
      child: const Text("Error not implemented yet"),
    ),
    redirect: (state) {
      return authStateListener.value.when(
        loading: () => null,
        authorized: () => state.location == rRoot.path ? state.namedLocation(rSubscriptions.name) : null,
        unauthorized: () => state.location == rUnauthorized.path ? null : state.namedLocation(rUnauthorized.name),
        error: (err) => null,
      );
    },
  );
}

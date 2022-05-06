import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_home/services/auth_provider.dart';
import 'package:cosmos_gov_web/f_home/services/state/auth_state.dart';
import 'package:cosmos_gov_web/f_home/widgets/loading_page.dart';
import 'package:cosmos_gov_web/f_login/widgets/login_page.dart';
import 'package:cosmos_gov_web/f_subscription/widgets/subscription_page.dart';
import 'package:cosmos_gov_web/f_voting/widgets/voting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<MyRouter>((ref) => MyRouter(ref.watch(authStateValueProvider)));

class MyRouter {
  final ValueNotifier<AuthState> authStateListener;

  MyRouter(this.authStateListener);

  late final router = GoRouter(
    refreshListenable: authStateListener,
    // debugLogDiagnostics: cDebugMode,
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
        name: rUnauthenticated.name,
        path: rUnauthenticated.path,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const LoginPage(),
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
        loading: () => state.subloc != rRoot.path ? state.namedLocation(rRoot.name, queryParams: {"from": state.subloc}) : null,
        authorized: () {
          // if `from` is set redirect there; if current page is / or /login redirect to /subscriptions
          final from = state.queryParams["from"] ?? "";
          if (from.isNotEmpty && state.subloc != from && from != rUnauthenticated.path) {
            return state.namedLocation(from);
          }
          if (state.subloc == rRoot.path || state.subloc == rUnauthenticated.path) {
            return state.namedLocation(rSubscriptions.name);
          }
          return null;
        },
        expired: () => state.subloc == rUnauthenticated.path ? null : state.namedLocation(rUnauthenticated.name),
        error: () =>
            state.subloc == rUnauthenticated.path ? null : state.namedLocation(rUnauthenticated.name, queryParams: {"error": "true"}),
      );
    },
  );
}

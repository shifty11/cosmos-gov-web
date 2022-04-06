import 'package:cosmos_gov_web/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_service.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

final authStatusProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authProvider)),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(const AuthState.loading()) {
    login();
    _authService.addListener(() {
      if (!_authService.isAuthenticated) {
        state = const AuthState.unauthorized();
      }
    });
  }

  Future<void> login() async {
    try {
      state = const AuthState.loading();
      await _authService.init();
      state = const AuthState.authorized();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }
}

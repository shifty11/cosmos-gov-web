@JS()
library script.js;

import 'dart:async';

import 'package:cosmos_gov_web/api/protobuf/dart/auth_service.pbgrpc.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_home/services/jwt_manager.dart';
import 'package:cosmos_gov_web/f_home/services/type/login_data.dart';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';
import 'package:js/js.dart';

@JS()
external String getTelegramInitData();

class AuthService extends AuthServiceClient with ChangeNotifier {
  static AuthService? _singleton;

  final Duration refreshBeforeExpDuration;
  final JwtManager jwtManager;

  factory AuthService(
          ClientChannelBase channel, Iterable<ClientInterceptor> interceptors, JwtManager jwtManager, refreshBeforeExpDuration) =>
      _singleton ??= AuthService._internal(channel, interceptors, jwtManager, refreshBeforeExpDuration);

  AuthService._internal(ClientChannelBase channel, Iterable<ClientInterceptor> interceptors, this.jwtManager, this.refreshBeforeExpDuration)
      : super(channel, interceptors: interceptors);

  init() async {
    if (canRefreshAccessToken) {
      try {
        await _login();
      } catch (e) {
        await _refreshAccessToken();
        if (!isAuthenticated) {
          rethrow;
        }
      }
    } else {
      await _login();
    }
    _scheduleRefreshAccessToken();
  }

  bool get isAuthenticated {
    return jwtManager.isAccessTokenValid;
  }

  bool get canRefreshAccessToken {
    return jwtManager.isRefreshTokenValid;
  }

  LoginData _getLoginData() {
    final loginData = LoginData(Uri.base.queryParameters.entries.map((e) => "${e.key}=${e.value}").join("\n"));
    if (loginData.isValid) {
      return loginData;
    }
    final data = getTelegramInitData();
    if (data.isNotEmpty) {
      final loginData = LoginData(Uri.decodeComponent(data));
      if (loginData.isValid) {
        return loginData;
      }
    } else {
      throw Exception("Login information are not available");
    }
    throw Exception("Login information are not available");
  }

  _login() async {
    if (cDebugMode) {
      print("AuthService: login");
    }
    final loginData = _getLoginData();
    var data = TelegramLoginRequest(
      userId: loginData.id,
      dataStr: loginData.data,
      username: loginData.username,
      authDate: loginData.authDate,
      hash: loginData.hash,
    );
    var response = await telegramLogin(data);
    jwtManager.accessToken = response.accessToken;
    jwtManager.refreshToken = response.refreshToken;
  }

  _logout() {
    if (cDebugMode) {
      print("AuthService: logout");
    }
    jwtManager.accessToken = "";
    jwtManager.refreshToken = "";
    notifyListeners();
  }

  Future<bool> _refreshAccessToken() async {
    if (cDebugMode) {
      print("AuthService: Refresh access token");
    }
    try {
      var response = await refreshAccessToken(RefreshAccessTokenRequest(refreshToken: jwtManager.refreshToken));
      jwtManager.accessToken = response.accessToken;
      return true;
    } catch (e) {
      if (cDebugMode) {
        print("AuthService: Error while refreshing access token: $e");
      }
    }
    return false;
  }

  _scheduleRefreshAccessToken() {
    try {
      final int exp = jwtManager.accessTokenDecoded["exp"] ?? 0;
      var expDateTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      var sleep = expDateTime.subtract(refreshBeforeExpDuration).difference(DateTime.now()).inSeconds;
      if (sleep <= 0) {
        sleep = 0;
      }
      if (cDebugMode) {
        print("AuthService: sleep for $sleep seconds");
      }
      Timer(Duration(seconds: sleep), () async {
        bool hasRefreshed = false;
        if (canRefreshAccessToken) {
          hasRefreshed = await _refreshAccessToken();
          _scheduleRefreshAccessToken();
        }
        if (!hasRefreshed) {
          _logout();
        }
      });
    } on FormatException catch (e) {
      if (cDebugMode) {
        print("AuthService: Error while executing _scheduleRefreshAccessToken: $e");
      }
      _logout();
      return;
    }
  }
}

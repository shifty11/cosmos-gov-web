import 'dart:async';

import 'package:cosmos_gov_web/api/protobuf/dart/auth_service.pbgrpc.dart';
import 'package:cosmos_gov_web/f_home/services/jwt_manager.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

class AuthService extends AuthServiceClient with ChangeNotifier {
  static AuthService? _singleton;

  static const refreshBeforeExpDuration = Duration(seconds: 235);
  final JwtManager jwtManager;

  factory AuthService(ClientChannelBase channel, Iterable<ClientInterceptor> interceptors, JwtManager jwtManager) =>
      _singleton ??= AuthService._internal(channel, interceptors, jwtManager);

  AuthService._internal(ClientChannelBase channel, Iterable<ClientInterceptor> interceptors, this.jwtManager) : super(channel, interceptors: interceptors);

  init() async {
    if (!isAuthenticated) {
      await _login();
    }
    _scheduleRefreshAccessToken();
  }

  bool get isAuthenticated {
    return jwtManager.accessToken.isNotEmpty;
  }

  _login() async {
    if (kDebugMode) {
      print("AuthService: login");
    }
    var token = Uri.base.queryParameters['token'] ?? "123";
    // var token = Uri.base.queryParameters['token'] ?? "";
    var chatIdStr = Uri.base.queryParameters['chatId'] ?? "194140490";
    var typeStr = Uri.base.queryParameters['type'] ?? "telegram";
    var type = TokenLoginRequest_Type.DISCORD;
    if (token.isEmpty || chatIdStr.isEmpty || typeStr.isEmpty) {
      throw Exception("Login information are not available");
    }

    var chatId = int.parse(chatIdStr);
    if (typeStr == "telegram") {
      type = TokenLoginRequest_Type.TELEGRAM;
    }
    try {
      var response = await tokenLogin(TokenLoginRequest(token: token, chatId: Int64(chatId), tYPE: type));
      jwtManager.accessToken = response.accessToken;
      jwtManager.refreshToken = response.refreshToken;
    } catch (e) {
      rethrow;
    }
  }

  _logout() {
    if (kDebugMode) {
      print("AuthService: logout");
    }
    jwtManager.accessToken = "";
    jwtManager.refreshToken = "";
    notifyListeners();
  }

  _scheduleRefreshAccessToken() {
    int exp = jwtManager.accessTokenDecoded["exp"] ?? 0;
    var expDateTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    var sleep = expDateTime.subtract(refreshBeforeExpDuration).difference(DateTime.now()).inSeconds;
    if (sleep <= 0) {
      sleep = 0;
    }
    if (kDebugMode) {
      print("AuthService: sleep for $sleep seconds");
    }
    Timer(Duration(seconds: sleep), () async {
      try {
        if (kDebugMode) {
          print("AuthService: Refresh access token");
        }
        if (jwtManager.refreshToken.isEmpty) {
          _logout();
        } else {
          var response = await refreshAccessToken(RefreshAccessTokenRequest(refreshToken: jwtManager.refreshToken));
          jwtManager.accessToken = response.accessToken;
          _scheduleRefreshAccessToken();
        }
      } catch (e) {
        if (kDebugMode) {
          print("AuthService: Error while refreshing access token: $e");
        }
        _logout();
      }
    });
  }
}

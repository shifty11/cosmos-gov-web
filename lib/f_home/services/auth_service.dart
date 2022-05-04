import 'dart:async';

import 'package:cosmos_gov_web/api/protobuf/dart/auth_service.pbgrpc.dart';
import 'package:cosmos_gov_web/f_home/services/jwt_manager.dart';
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

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
    if (!isAuthenticated) {
      await _login();
    } else if (kDebugMode) {
      print("AuthService: is authenticated");
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
    var idStr = Uri.base.queryParameters['id'] ?? "";
    var username = Uri.base.queryParameters['username'] ?? "";
    var authDateStr = Uri.base.queryParameters['auth_date'] ?? "";
    var hash = Uri.base.queryParameters['hash'] ?? "";
    if (idStr.isEmpty || username.isEmpty || authDateStr.isEmpty || hash.isEmpty) {
      throw Exception("Login information are not available");
    }

    var id = int.tryParse(idStr);
    var authDate = int.tryParse(authDateStr);
    if (id == null || authDate == null) {
      throw Exception("Login information could not be parsed");
    }

    List<String> dataList = [];
    Uri.base.queryParameters.forEach((key, value) {
      if (key != "hash") {
        dataList.add("$key=$value");
      }
    });
    dataList.sort(((a, b) => a.compareTo(b)));

    try {
      var data = TelegramLoginRequest(
          userId: fixnum.Int64(id), dataStr: dataList.join("\\n"), username: username, authDate: fixnum.Int64(authDate), hash: hash);
      var response = await telegramLogin(data);
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

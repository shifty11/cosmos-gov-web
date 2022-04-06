import 'dart:convert';
import 'dart:html' show window;

class JwtManager {
  static JwtManager? _singleton;

  String _accessToken = "";
  String _refreshToken = "";
  final storage = window.localStorage;

  factory JwtManager() => _singleton ??= JwtManager._internal();

  JwtManager._internal() {
    _accessToken = storage["accessToken"] ?? "";
    _refreshToken = storage["refreshToken"] ?? "";
  }

  set accessToken(String accessToken) {
    _accessToken = accessToken;
    if (accessToken.isEmpty) {
      storage.remove("accessToken");
    } else {
      storage["accessToken"] = accessToken;
    }
  }

  String get accessToken {
    return _accessToken;
  }

  Map<String, dynamic> get accessTokenDecoded {
    return json.decode(ascii.decode(base64.decode(base64.normalize(_accessToken.split(".")[1]))));
  }

  set refreshToken(String refreshToken) {
    _refreshToken = refreshToken;
    if (refreshToken.isEmpty) {
      storage.remove("refreshToken");
    } else {
      storage["refreshToken"] = refreshToken;
    }
  }

  String get refreshToken {
    return _refreshToken;
  }

  String get refreshTokenDecoded {
    return json.decode(ascii.decode(base64.decode(base64.normalize(_refreshToken.split(".")[1]))));
  }
}

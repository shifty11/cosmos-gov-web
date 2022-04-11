import 'dart:async';

import 'package:cosmos_gov_web/f_home/services/jwt_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';

class AuthInterceptor extends ClientInterceptor {
  static AuthInterceptor? _singleton;
  JwtManager jwtManager;

  String? accessToken;

  String? refreshToken;

  factory AuthInterceptor(JwtManager jwtManager) => _singleton ??= AuthInterceptor._internal(jwtManager);

  AuthInterceptor._internal(this.jwtManager);

  FutureOr<void> _attachToken(Map<String, String> metadata, String uri) async {
    final token = jwtManager.accessToken;
    metadata['Authorization'] = "Bearer $token";
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request, CallOptions options, invoker) {
    if (kDebugMode) {
      print("interceptUnary --> ${method.path}");
    }

    if (isAuthNeeded(method.path)) {
      options = options.mergedWith(CallOptions(providers: [_attachToken]));
    }
    return super.interceptUnary(method, request, options, invoker);
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method, Stream<Q> requests, CallOptions options, ClientStreamingInvoker<Q, R> invoker) {
    if (kDebugMode) {
      print("interceptStreaming --> ${method.path}");
    }

    if (isAuthNeeded(method.path)) {
      options = options.mergedWith(CallOptions(providers: [_attachToken]));
    }

    return super.interceptStreaming(method, requests, options, invoker);
  }

  Map<String, bool> authMethod() {
    const path = "/cosmosgov_grpc.AuthService/";

    return {path + "TokenLogin": false, path + "RefreshAccessToken": false};
  }

  bool isAuthNeeded(String method) {
    var authInfo = authMethod()[method];
    if (authInfo == null) {
      return true;
    }
    return authInfo;
  }
}
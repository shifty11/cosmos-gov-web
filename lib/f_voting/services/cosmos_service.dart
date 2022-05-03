// ignore_for_file: avoid_web_libraries_in_flutter
@JS()
library script.js;

import 'dart:html';
import 'dart:js' as js;
import 'dart:js_util';

import 'package:flutter/foundation.dart';
import 'package:js/js.dart';

@JS()
external dynamic getAccountJs(String chainId);

@JS()
external dynamic grantMsgVoteJs(String chainId, String rpcAddress, String granter, String grantee, int expiration, String denom, bool debug);

@JS()
external dynamic revokeMsgVoteJs(String chainId, String rpcAddress, String granter, String grantee, bool debug);

class CosmosService with ChangeNotifier {
  static CosmosService? _singleton;

  factory CosmosService() => _singleton ??= CosmosService._internal();

  CosmosService._internal() {
    setProperty(window, 'keplr_keystorechange_dart', js.allowInterop(keplrKeystorechange));
  }

  String keplrKeystorechange() {
    notifyListeners();
    return 'Called from javascript: keplrKeystorechange';
  }

  Future<dynamic> getAddress(String chainId) async {
    return await promiseToFuture(getAccountJs(chainId));
  }

  Future<dynamic> grantVote(String chainId, String rpcAddress, String granter, String grantee, int expiration, String denom) async {
    return await promiseToFuture(grantMsgVoteJs(chainId, rpcAddress, granter, grantee, expiration, denom, kDebugMode));
  }

  Future<dynamic> revokeVote(String chainId, String rpcAddress, String granter, String grantee) async {
    return await promiseToFuture(revokeMsgVoteJs(chainId, rpcAddress, granter, grantee, kDebugMode));
  }
}

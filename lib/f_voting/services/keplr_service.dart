// ignore_for_file: avoid_web_libraries_in_flutter
@JS()
library script.js;

import 'dart:html';
import 'dart:js' as js;
import 'dart:js_util';

import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pbgrpc.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:flutter/foundation.dart';
import 'package:js/js.dart';

@JS()
external dynamic getAccountJs(String chainId);

@JS()
external dynamic grantMsgVoteJs(String chainId, String rpcAddress, String granter, String grantee, int expiration, String denom, bool isFeegrantUsed, bool debug);

@JS()
external dynamic revokeMsgVoteJs(String chainId, String rpcAddress, String granter, String grantee, bool isFeegrantUsed, bool debug);

class KeplrService with ChangeNotifier {
  static KeplrService? _singleton;

  factory KeplrService() => _singleton ??= KeplrService._internal();

  KeplrService._internal() {
    setProperty(window, 'keplr_keystorechange_dart', js.allowInterop(keplrKeystorechange));
  }

  String keplrKeystorechange() {
    notifyListeners();
    return 'Called from javascript: keplrKeystorechange';
  }

  Future<dynamic> getAddress(String chainId) async {
    return await promiseToFuture(getAccountJs(chainId));
  }

  Future<dynamic> grantVote(Chain chain, String granter, int expiration) async {
    return await promiseToFuture(grantMsgVoteJs(chain.chainId, chain.rpcAddress, granter, chain.grantee, expiration, chain.denom, chain.isFeegrantUsed, cDebugMode));
  }

  Future<dynamic> revokeVote(Chain chain, String granter) async {
    return await promiseToFuture(revokeMsgVoteJs(chain.chainId, chain.rpcAddress, granter, chain.grantee, chain.isFeegrantUsed, cDebugMode));
  }
}

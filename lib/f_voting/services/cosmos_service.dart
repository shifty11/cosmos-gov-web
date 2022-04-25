// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:js' as js;
import 'dart:js_util';

class CosmosService {
  static CosmosService? _singleton;

  factory CosmosService() => _singleton ??= CosmosService._internal();

  CosmosService._internal() {
    setProperty(window, 'keplr_keystorechange_dart', js.allowInterop(keplrKeystorechange));
  }

  String keplrKeystorechange() {
    return 'Called from javascript: keplrKeystorechange';
  }

  js.JsObject getGrant(String granter, String grantee, int expiration) {
    return js.JsObject.jsify([
      {
        "typeUrl": "/cosmos.authz.v1beta1.MsgGrant",
        "value": {
          "granter": granter,
          "grantee": grantee,
          "grant": {
            "authorization": {
              "typeUrl": "/cosmos.authz.v1beta1.GenericAuthorization",
              "value": "/cosmos.gov.v1beta1.MsgVote",
            },
            "expiration": {"seconds": expiration},
          },
        }
      },
      // {
      //   "typeUrl": "/cosmos.feegrant.v1beta1.MsgGrantAllowance",
      //   "value": {
      //     "granter": granter,
      //     "grantee": grantee,
      //     "allowance": {
      //       "typeUrl": "/cosmos.feegrant.v1beta1.AllowedMsgAllowance",
      //       "value": {
      //         "allowance": {
      //           "typeUrl": "/cosmos.feegrant.v1beta1.BasicAllowance",
      //           "value": {
      //             "spendLimit": [
      //               {"denom": "ujuno", "amount": "5000"}
      //             ],
      //             "expiration": {"seconds": expiration}
      //           }
      //         },
      //         "allowedMessages": ["/cosmos.gov.v1beta1.MsgVote"]
      //       },
      //     },
      //   }
      // },
    ]);
  }

  js.JsObject getRevoke(String granter, String grantee) {
    return js.JsObject.jsify([
      {
        "typeUrl": "/cosmos.authz.v1beta1.MsgRevoke",
        "value": {
          "granter": granter,
          "grantee": grantee,
          "msgTypeUrl": "/cosmos.gov.v1beta1.MsgVote",
        },
      },
      // {
      //   "typeUrl": "/cosmos.feegrant.v1beta1.MsgRevokeAllowance",
      //   "value": {
      //     "granter": granter,
      //     "grantee": grantee,
      //   },
      // }
    ]);
  }

  js.JsObject getFee() {
    return js.JsObject.jsify({
      "amount": [
        {
          "denom": 'uosmo',
          "amount": '5000',
        },
      ],
      "gas": '200000',
    });
  }

  executeGrant(String chainId, String rpcAddress, String granter, String grantee, int expiration) {
    try {
      final grant = getGrant(granter, grantee, expiration);
      js.context.callMethod('grantMsgVote', [chainId, rpcAddress, grant, getFee()]);
    } on Exception catch (e) {
      print(e);
    }
  }
}

async function getAccountJs(chainId) {
    await window.keplr.enable(chainId);
    const offlineSigner = window.getOfflineSigner(chainId);
    const accounts = await offlineSigner.getAccounts();
    return accounts[0].address;
}

function buildGrant(granter, grantee, expiration, denom, isFeegrantUsed) {
    const msgs = [{
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
    ];
    if (isFeegrantUsed) {
        msgs.push({
                   "typeUrl": "/cosmos.feegrant.v1beta1.MsgGrantAllowance",
                   "value": {
                     "granter": granter,
                     "grantee": grantee,
                     "allowance": {
                       "typeUrl": "/cosmos.feegrant.v1beta1.AllowedMsgAllowance",
                       "value": {
                         "allowance": {
                           "typeUrl": "/cosmos.feegrant.v1beta1.BasicAllowance",
                           "value": {
                             "spendLimit": [
                               {"denom": denom, "amount": "5000"}
                             ],
                             "expiration": {"seconds": expiration}
                           }
                         },
                         "allowedMessages": ["/cosmos.gov.v1beta1.MsgVote"]
                       },
                     },
                   }
                 });
    }
    return msgs;
}

function buildRevoke(granter, grantee, isFeegrantUsed) {
    const msgs = [
      {
        "typeUrl": "/cosmos.authz.v1beta1.MsgRevoke",
        "value": {
          "granter": granter,
          "grantee": grantee,
          "msgTypeUrl": "/cosmos.gov.v1beta1.MsgVote",
        },
      },
    ];
    if (isFeegrantUsed) {
        msgs.push({
                   "typeUrl": "/cosmos.feegrant.v1beta1.MsgRevokeAllowance",
                   "value": {
                     "granter": granter,
                     "grantee": grantee,
                   },
                 });
    }
    return msgs;
}

function buildFee() {
    return {
      "amount": [
        {
          "denom": 'uosmo',
          "amount": '5000',
        },
      ],
      "gas": '200000',
    };
}

async function grantMsgVoteJs(chainId, rpcAddress, granter, grantee, expiration, denom, isFeegrantUsed, debug) {
    await window.keplr.enable(chainId);
    const offlineSigner = window.getOfflineSigner(chainId);
    const accounts = await offlineSigner.getAccounts();

    const client = await window.SigningStargateClient.connectWithSigner(rpcAddress, offlineSigner);

    client.registry.register("/cosmos.authz.v1beta1.MsgGrant", window.MsgGrant)
    client.registry.register("/cosmos.feegrant.v1beta1.MsgGrantAllowance", window.MsgGrantAllowance)

    messages = buildGrant(granter, grantee, expiration, denom, isFeegrantUsed);
    fee = buildFee();

    if (debug) console.log(messages);

    const genericAuthorization = messages[0].value.grant.authorization.value;
    messages[0].value.grant.authorization.value = window.GenericAuthorization.encode(
        window.GenericAuthorization.fromPartial({msg: genericAuthorization})
    ).finish();

    if (isFeegrantUsed) {
        const basicAllowanceValue = messages[1].value.allowance.value.allowance.value;
        const basicAllowance = window.BasicAllowance.fromPartial(basicAllowanceValue);
        const basicAllowanceEncoded = BasicAllowance.encode(basicAllowance).finish()

        const allowedMessageAllowanceValue = messages[1].value.allowance.value
        allowedMessageAllowanceValue.allowance.value = basicAllowanceEncoded
        const allowedMessageAllowanceEncoded = AllowedMsgAllowance.encode(allowedMessageAllowanceValue).finish();
        messages[1].value.allowance.value = allowedMessageAllowanceEncoded
    }

    try {
        const result = await client.signAndBroadcast(accounts[0].address, messages, fee, "")
        if (debug) console.log(result);
        return result
    } catch(err) {
        if (debug) console.log(err);
        return
    }
}

async function revokeMsgVoteJs(chainId, rpcAddress, granter, grantee, isFeegrantUsed, debug) {
    await window.keplr.enable(chainId);
    const offlineSigner = window.getOfflineSigner(chainId);
    const accounts = await offlineSigner.getAccounts();

    const client = await window.SigningStargateClient.connectWithSigner(rpcAddress, offlineSigner);

    client.registry.register("/cosmos.authz.v1beta1.MsgRevoke", window.MsgRevoke)
    client.registry.register("/cosmos.feegrant.v1beta1.MsgRevokeAllowance", window.MsgRevokeAllowance)

    messages = buildRevoke(granter, grantee, isFeegrantUsed);
    fee = buildFee();

    if (debug) console.log(messages);

    try {
        const result = await client.signAndBroadcast(accounts[0].address, messages, fee, "")
        if (debug) console.log(result);
        return result
    } catch(err) {
        if (debug) console.log(err);
        return
    }
}

window.addEventListener("keplr_keystorechange", () => {
    console.log(window.keplr_keystorechange_dart())
})

window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });
}

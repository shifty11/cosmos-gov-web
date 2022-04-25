async function grantMsgVote(chainId, rpcAddress, messages, fee) {
    await window.keplr.enable(chainId);
    const offlineSigner = window.getOfflineSigner(chainId);
    const accounts = await offlineSigner.getAccounts();

    const client = await window.SigningStargateClient.connectWithSigner(rpcAddress, offlineSigner);

    client.registry.register("/cosmos.authz.v1beta1.MsgGrant", window.MsgGrant)
//    client.registry.register("/cosmos.feegrant.v1beta1.MsgGrantAllowance", window.MsgGrantAllowance)

    const genericAuthorization = messages[0].value.grant.authorization.value;
    messages[0].value.grant.authorization.value = window.GenericAuthorization.encode(
        window.GenericAuthorization.fromPartial({msg: genericAuthorization})
    ).finish();

//    const basicAllowanceValue = messages[1].value.allowance.value.allowance.value;
//    const basicAllowance = window.BasicAllowance.fromPartial(basicAllowanceValue);
//    const basicAllowanceEncoded = BasicAllowance.encode(basicAllowance).finish()
//
//    const allowedMessageAllowanceValue = messages[1].value.allowance.value
//    allowedMessageAllowanceValue.allowance.value = basicAllowanceEncoded
//    const allowedMessageAllowanceEncoded = AllowedMsgAllowance.encode(allowedMessageAllowanceValue).finish();
//    messages[1].value.allowance.value = allowedMessageAllowanceEncoded

    console.log(messages);

    const result = await client.signAndBroadcast(accounts[0].address, messages, fee, "")

    console.log(result);
}

async function revokeMsgVote(chainId, rpcAddress, messages, fee) {
    await window.keplr.enable(chainId);
    const offlineSigner = window.getOfflineSigner(chainId);
    const accounts = await offlineSigner.getAccounts();

    const client = await window.SigningStargateClient.connectWithSigner(rpcAddress, offlineSigner);

    client.registry.register("/cosmos.authz.v1beta1.MsgRevoke", window.MsgRevoke)
    client.registry.register("/cosmos.feegrant.v1beta1.MsgRevokeAllowance", window.MsgRevokeAllowance)

    console.log(messages);

    const result = await client.signAndBroadcast(accounts[0].address, messages, fee, "")

    console.log(result);
}

window.addEventListener("keplr_keystorechange", () => {
    console.log(window.keplr_keystorechange_dart())
})

window.logger = (flutter_value) => {
   console.log({ js_context: this, flutter_value });
}

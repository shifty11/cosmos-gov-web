import 'package:cosmos_gov_web/f_admin/services/admin_provider.dart';
import 'package:cosmos_gov_web/f_home/services/state/message_state.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/keplr_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider = StateNotifierProvider<MessageNotifier, MessageState>((ref) => MessageNotifier(ref));

class MessageNotifier extends MessageNotifierBase {
  MessageNotifier(StateNotifierProviderRef<MessageNotifierBase, MessageState> ref) : super(ref) {
    ref.watch(chatroomListStateProvider).whenOrNull(error: (err, _) => sendMsg(error: err.toString()));
    ref.watch(chainListStateProvider).whenOrNull(error: (err, _) => sendMsg(error: err.toString()));
    ref.watch(walletListProvider).whenOrNull(error: (err, stackTrace) => sendMsg(error: err.toString()));
    ref.watch(keplrTxProvider).whenOrNull(executed: (success, info) => sendMsg(info: info), error: (err) => sendMsg(error: err.toString()));
    ref.watch(chainListStateProvider).whenOrNull(error: (err, _) => sendMsg(error: err.toString()));
  }
}

class MessageNotifierBase extends StateNotifier<MessageState> {
  StateNotifierProviderRef<MessageNotifierBase, MessageState> ref;

  MessageNotifierBase(this.ref) : super(const MessageState.initial());

  sendMsg({String? info, String? error}) async {
    state = MessageState.received(info: info, error: error);
    await Future.delayed(const Duration(seconds: 1));
    state = const MessageState.initial();
  }
}

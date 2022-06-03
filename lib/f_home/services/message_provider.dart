import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_admin/services/admin_provider.dart';
import 'package:cosmos_gov_web/f_home/services/jwt_manager.dart';
import 'package:cosmos_gov_web/f_home/services/state/message_state.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/keplr_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final messageProvider = StateNotifierProvider<MessageNotifier, MessageState>((ref) => MessageNotifier(ref, jwtManager));

class MessageNotifier extends MessageNotifierBase {
  MessageNotifier(StateNotifierProviderRef<MessageNotifierBase, MessageState> ref, JwtManager jwtManager) : super(ref, jwtManager) {
    ref.watch(chatroomListStateProvider).whenOrNull(error: (err, _) => sendMsg(error: err.toString()));
    if (jwtManager.isAdmin) {
      ref.watch(chainListStateProvider).whenOrNull(error: (err, _) => sendMsg(error: err.toString()));
      ref.watch(walletListProvider).whenOrNull(error: (err, stackTrace) => sendMsg(error: err.toString()));
      ref.watch(keplrTxProvider).whenOrNull(executed: (success, info) => sendMsg(info: info), error: (err) => sendMsg(error: err.toString()));
    }
  }
}

class MessageNotifierBase extends StateNotifier<MessageState> {
  final StateNotifierProviderRef<MessageNotifierBase, MessageState> ref;
  final JwtManager jwtManager;

  MessageNotifierBase(this.ref, this.jwtManager) : super(const MessageState.initial());

  sendMsg({String? info, String? error}) async {
    state = MessageState.received(info: info, error: error);
    await Future.delayed(const Duration(seconds: 1));
    state = const MessageState.initial();
  }
}

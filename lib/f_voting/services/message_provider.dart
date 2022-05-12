import 'package:cosmos_gov_web/f_admin/services/admin_provider.dart';
import 'package:cosmos_gov_web/f_home/services/message_provider.dart';
import 'package:cosmos_gov_web/f_home/services/state/message_state.dart';
import 'package:cosmos_gov_web/f_voting/services/keplr_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final votingMsgProvider = StateNotifierProvider<MessageNotifier, MessageState>((ref) => MessageNotifier(ref));

class MessageNotifier extends MessageNotifierBase {
  MessageNotifier(StateNotifierProviderRef<MessageNotifierBase, MessageState> ref) : super(ref) {
    ref.watch(chainListStateProvider).whenOrNull(error: (err, _) => sendMsg(error: err.toString()));
    ref.watch(votePermissionListStateProvider).whenOrNull(error: (err) => sendMsg(error: err.toString()));
    ref.watch(keplrTxProvider).whenOrNull(executed: (success, info) => sendMsg(info: info), error: (err) => sendMsg(error: err.toString()));
  }
}

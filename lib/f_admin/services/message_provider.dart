import 'package:cosmos_gov_web/f_admin/services/admin_provider.dart';
import 'package:cosmos_gov_web/f_home/services/message_provider.dart';
import 'package:cosmos_gov_web/f_home/services/state/message_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminMsgProvider = StateNotifierProvider<MessageNotifier, MessageState>((ref) => MessageNotifier(ref));

class MessageNotifier extends MessageNotifierBase {
  MessageNotifier(StateNotifierProviderRef<MessageNotifierBase, MessageState> ref) : super(ref) {
    ref.watch(chainListStateProvider).whenOrNull(error: (err, _) => sendMsg(error: err.toString()));
  }
}

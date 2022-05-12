import 'package:cosmos_gov_web/f_home/services/state/message_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageNotifierBase extends StateNotifier<MessageState> {
  StateNotifierProviderRef<MessageNotifierBase, MessageState> ref;

  MessageNotifierBase(this.ref) : super(const MessageState.initial());

  sendMsg({String? info, String? error}) {
    state = MessageState.received(info: info, error: error);
    state = const MessageState.initial();
  }
}

import 'package:cosmos_gov_web/api/protobuf/dart/google/protobuf/empty.pb.dart';
import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pb.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_subscription/services/state/chat_room_list_state.dart';
import 'package:cosmos_gov_web/f_subscription/services/state/subscription_state.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_service.dart';
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protobuf/protobuf.dart';
import 'package:tuple/tuple.dart';

final subscriptionProvider = Provider<SubscriptionService>((ref) => subsService);

final chatroomListStateProvider = StateNotifierProvider<ChatRoomListNotifier, ChatRoomListState>(
  (ref) => ChatRoomListNotifier(ref.watch(subscriptionProvider)),
);

class ChatRoomListNotifier extends StateNotifier<ChatRoomListState> {
  final SubscriptionService _subscriptionService;

  ChatRoomListNotifier(this._subscriptionService) : super(const ChatRoomListState.loading()) {
    get();
  }

  Future<void> get() async {
    try {
      state = const ChatRoomListState.loading();
      final response = await _subscriptionService.getSubscriptions(Empty());
      state = ChatRoomListState.loaded(response.chatRooms);
    } catch (e) {
      state = ChatRoomListState.error(e.toString());
    }
  }
}

final subscriptionStateProvider = StateNotifierProvider.family<SubscriptionNotifier, SubscriptionState, Tuple2<Subscription, fixnum.Int64>>(
  (ref, tuple) => SubscriptionNotifier(ref.watch(subscriptionProvider), tuple.item1, tuple.item2),
);

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionService _subscriptionService;
  final Subscription _subscription;
  final fixnum.Int64 _chatRoomId;

  SubscriptionNotifier(this._subscriptionService, this._subscription, this._chatRoomId)
      : super(SubscriptionState.loaded(subscription: _subscription));

  Future<void> toggleSubscription() async {
    try {
      final response =
          await _subscriptionService.toggleSubscription(ToggleSubscriptionRequest(chatRoomId: _chatRoomId, name: _subscription.name));
      _subscription.isSubscribed = response.isSubscribed;
      state = SubscriptionState.loaded(subscription: _subscription);
    } catch (e) {
      state = SubscriptionState.error(e.toString());
    }
  }
}

final searchProvider = StateProvider((ref) => "");

final chatRoomProvider = StateProvider<ChatRoom?>((ref) => null);

final searchedSubsProvider = Provider<ChatRoom>((ref) {
  final search = ref.watch(searchProvider);
  final chatRoom = ref.watch(chatRoomProvider);
  final subs = ref.watch(chatroomListStateProvider);
  return subs.whenOrNull(loaded: (chatRooms) {
        for (var cr in chatRooms) {
          if (cr == chatRoom || chatRoom == null) {
            if (search.isEmpty) {
              return cr;
            }
            final copy = GeneratedMessageGenericExtensions<ChatRoom>(cr).deepCopy();
            copy.subscriptions.removeWhere((sub) =>
                !sub.displayName.toLowerCase().contains(search.toLowerCase())
            );
            return copy;
          }
        }
        return ChatRoom();
      }) ??
      ChatRoom();
});

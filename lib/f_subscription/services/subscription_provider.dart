import 'package:cosmos_gov_web/api/protobuf/dart/google/protobuf/empty.pb.dart';
import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pb.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_subscription/services/state/subscription_state.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_service.dart';
import 'package:fixnum/fixnum.dart' as fixnum;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protobuf/protobuf.dart';
import 'package:tuple/tuple.dart';

final subscriptionProvider = Provider<SubscriptionService>((ref) => subsService);

final chatroomListStateProvider = FutureProvider<List<ChatRoom>>((ref) async {
  final subsService = ref.read(subscriptionProvider);
  final response = await subsService.getSubscriptions(Empty());
  return response.chatRooms;
});

final subscriptionStateProvider = StateNotifierProvider.family<SubscriptionNotifier, SubscriptionState, Tuple2<fixnum.Int64, int>>(
  (ref, tuple) {
    final chatRoom = ref.read(chatroomListStateProvider).value!.firstWhere((c) => c.id == tuple.item1);
    final subscription = chatRoom.subscriptions[tuple.item2];
    return SubscriptionNotifier(ref.watch(subscriptionProvider), subscription, chatRoom.id);
  },
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

final searchSubsProvider = StateProvider((ref) => "");

final chatRoomProvider = StateProvider<ChatRoom?>((ref) => null);

final searchedSubsProvider = Provider<ChatRoom>((ref) {
  final search = ref.watch(searchSubsProvider);
  final chatRoom = ref.watch(chatRoomProvider);
  final subs = ref.watch(chatroomListStateProvider);
  return subs.whenOrNull(data: (chatRooms) {
        for (var cr in chatRooms) {
          if (cr == chatRoom || chatRoom == null) {
            if (search.isEmpty) {
              return cr;
            }
            final copy = GeneratedMessageGenericExtensions<ChatRoom>(cr).deepCopy();
            copy.subscriptions.removeWhere((sub) => !sub.displayName.toLowerCase().contains(search.toLowerCase()));
            return copy;
          }
        }
        return ChatRoom();
      }) ??
      ChatRoom();
});

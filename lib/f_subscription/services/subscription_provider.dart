import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pbgrpc.dart';
import 'package:cosmos_gov_web/f_subscription/services/state/subscription_list_state.dart';
import 'package:cosmos_gov_web/f_subscription/services/state/subscription_state.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscriptionProvider = Provider<SubscriptionService>((ref) => subsService);

final subscriptionListStateProvider = StateNotifierProvider<SubscriptionListNotifier, SubscriptionListState>(
  (ref) => SubscriptionListNotifier(ref.watch(subscriptionProvider)),
);

class SubscriptionListNotifier extends StateNotifier<SubscriptionListState> {
  final SubscriptionService _subscriptionService;

  SubscriptionListNotifier(this._subscriptionService) : super(const SubscriptionListState.loading()) {
    login();
  }

  Future<void> login() async {
    try {
      state = const SubscriptionListState.loading();
      final response = await _subscriptionService.getSubscriptions(GetSubscriptionsRequest());
      state = SubscriptionListState.loaded(response.subscriptions);
    } catch (e) {
      state = SubscriptionListState.error(e.toString());
    }
  }
}

final subscriptionStateProvider = StateNotifierProvider.family<SubscriptionNotifier, SubscriptionState, Subscription>(
  (ref, subscription) => SubscriptionNotifier(ref.watch(subscriptionProvider), subscription),
);

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionService _subscriptionService;
  final Subscription _subscription;

  SubscriptionNotifier(this._subscriptionService, this._subscription) : super(SubscriptionState.loaded(subscription: _subscription));

  Future<void> toggleSubscription() async {
    try {
      final response = await _subscriptionService.toggleSubscription(ToggleSubscriptionRequest(name: _subscription.name));
      _subscription.isSubscribed = response.isSubscribed;
      state = SubscriptionState.loaded(subscription: _subscription);
    } catch (e) {
      state = SubscriptionState.error(e.toString());
    }
  }
}

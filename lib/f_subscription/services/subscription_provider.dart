import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pbgrpc.dart';
import 'package:cosmos_gov_web/f_home/services/auth_provider.dart';
import 'package:cosmos_gov_web/f_subscription/services/state/subscription_state.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final subscriptionProvider = Provider<SubscriptionService>((ref) => SubscriptionService(channel, [authInterceptor]));

final subscriptionStateProvider = StateNotifierProvider<SubscriptionNotifier, SubscriptionState>(
  (ref) => SubscriptionNotifier(ref.watch(subscriptionProvider)),
);

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionService _subscriptionService;

  SubscriptionNotifier(this._subscriptionService) : super(const SubscriptionState.loading()) {
    login();
  }

  Future<void> login() async {
    try {
      state = const SubscriptionState.loading();
      final response = await _subscriptionService.getSubscriptions(GetSubscriptionsRequest());
      state = SubscriptionState.loaded();
      // state = SubscriptionState.loaded(response.subscriptions);
    } catch (e) {
      state = SubscriptionState.error(e.toString());
    }
  }
}

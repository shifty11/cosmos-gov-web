import 'package:cosmos_gov_web/f_subscription/widgets/subscription_widget.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_state.freezed.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const SubscriptionState._();

  const factory SubscriptionState.loading() = Loading;

  // factory SubscriptionState.loaded([@Default([]) List<SubscriptionPage> subscriptions]) = Loaded;
  factory SubscriptionState.loaded() = Loaded;

  factory SubscriptionState.error([String? message]) = Error;
}

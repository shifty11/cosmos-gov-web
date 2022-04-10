import 'package:cosmos_gov_web/api/protobuf/dart/subscription_service.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_list_state.freezed.dart';

@freezed
class SubscriptionListState with _$SubscriptionListState {
  const SubscriptionListState._();

  const factory SubscriptionListState.loading() = Loading;

  factory SubscriptionListState.loaded([@Default([]) List<Subscription> subscriptions]) = Loaded;

  factory SubscriptionListState.error([String? message]) = Error;
}

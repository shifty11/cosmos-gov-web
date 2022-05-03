import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cosmos_state.freezed.dart';

@freezed
class CosmosState with _$CosmosState {
  const CosmosState._();

  const factory CosmosState.initial() = Initial;

  const factory CosmosState.connected({required String chainId, required String address}) = Connected;

  factory CosmosState.executing({required Chain chain}) = Executing;

  factory CosmosState.executed({required bool success, required String txHash, required String rawLog}) = Executed;

  factory CosmosState.error({required String error}) = Error;
}

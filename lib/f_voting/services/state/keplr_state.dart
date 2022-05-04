import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keplr_state.freezed.dart';

@freezed
class KeplrState with _$KeplrState {
  const KeplrState._();

  const factory KeplrState.initial() = Initial;

  const factory KeplrState.connected({required String chainId, required String address}) = Connected;

  factory KeplrState.executing({required Chain chain}) = Executing;

  factory KeplrState.executed({required bool success, required String txHash, required String rawLog}) = Executed;

  factory KeplrState.error({required String error}) = Error;
}

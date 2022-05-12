import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'keplr_tx_state.freezed.dart';

@freezed
class KeplrTxState with _$KeplrTxState {
  const KeplrTxState._();

  const factory KeplrTxState.initial() = Initial;

  factory KeplrTxState.executing({required Chain chain}) = Executing;

  factory KeplrTxState.executed({required bool success, String? info}) = Executed;

  factory KeplrTxState.error({required String error}) = Error;
}

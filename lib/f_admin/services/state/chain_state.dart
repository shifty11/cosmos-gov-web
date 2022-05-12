import 'package:cosmos_gov_web/api/protobuf/dart/admin_service.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain_state.freezed.dart';

@freezed
class ChainState with _$ChainState {
  const ChainState._();

  factory ChainState.loaded({required ChainSettings chain}) = Loaded;

  factory ChainState.error([String? message]) = Error;
}

import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain_list_state.freezed.dart';

@freezed
class ChainListState with _$ChainListState {
  const ChainListState._();

  const factory ChainListState.loading() = Loading;

  factory ChainListState.loaded({required List<Chain> chains}) = Loaded;

  factory ChainListState.error([String? message]) = Error;
}

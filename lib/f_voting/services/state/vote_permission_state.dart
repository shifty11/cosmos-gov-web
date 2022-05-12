import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_permission_state.freezed.dart';

@freezed
class VotePermissionState with _$VotePermissionState {
  const VotePermissionState._();

  factory VotePermissionState.loaded({required VotePermission votePermission}) = Loaded;
}

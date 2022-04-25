import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'vote_permission_list_state.freezed.dart';

@freezed
class VotePermissionListState with _$VotePermissionListState {
  const VotePermissionListState._();

  const factory VotePermissionListState.loading() = Loading;

  factory VotePermissionListState.loaded([@Default([]) List<VotePermission> votePermissions]) = Loaded;

  factory VotePermissionListState.error([String? message]) = Error;
}

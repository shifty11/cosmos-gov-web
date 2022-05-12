import 'package:cosmos_gov_web/api/protobuf/dart/google/protobuf/empty.pb.dart';
import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pbgrpc.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_voting/services/message_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/state/vote_permission_list_state.dart';
import 'package:cosmos_gov_web/f_voting/services/state/vote_permission_state.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final votePermissionProvider = Provider<VotePermissionService>((ref) => votePermissionService);

final votePermissionListStateProvider = StateNotifierProvider<VotePermissionListNotifier, VotePermissionListState>(
  (ref) => VotePermissionListNotifier(ref.watch(votePermissionProvider)),
);

class VotePermissionListNotifier extends StateNotifier<VotePermissionListState> {
  final VotePermissionService _votePermissionService;

  VotePermissionListNotifier(this._votePermissionService) : super(const VotePermissionListState.loading()) {
    get();
  }

  Future<void> get() async {
    try {
      state = const VotePermissionListState.loading();
      final response = await _votePermissionService.getVotePermissions(Empty());
      state = VotePermissionListState.loaded(response.votePermissions);
    } catch (e) {
      state = VotePermissionListState.error(e.toString());
    }
  }
}

final votePermissionStateProvider = StateNotifierProvider.family<VotePermissionNotifier, VotePermissionState, VotePermission>(
  (ref, votePermission) => VotePermissionNotifier(ref, votePermission),
);

class VotePermissionNotifier extends StateNotifier<VotePermissionState> {
  final VotePermission _votePermission;
  final StateNotifierProviderRef _ref;

  VotePermissionNotifier(this._ref, this._votePermission)
      : super(VotePermissionState.loaded(votePermission: _votePermission));

  Future<void> refreshVotePermission() async {
    try {
      final votePermissionService = _ref.read(votePermissionProvider);
      await votePermissionService.refreshVotePermission(RefreshVotePermissionRequest(votePermission: _votePermission));
      state = VotePermissionState.loaded(votePermission: _votePermission);
    } catch (e) {
      _ref.read(votingMsgProvider.notifier).sendMsg(error: e.toString());
    }
  }
}

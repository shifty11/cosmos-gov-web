import 'package:cosmos_gov_web/api/protobuf/dart/google/protobuf/empty.pb.dart';
import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/f_voting/services/state/chain_list_state.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chainListStateProvider = StateNotifierProvider<ChainListNotifier, ChainListState>(
  (ref) => ChainListNotifier(ref.watch(votePermissionProvider)),
);

final selectedChainProvider = StateProvider<Chain?>((ref) => null);

class ChainListNotifier extends StateNotifier<ChainListState> {
  final VotePermissionService _votePermissionService;

  ChainListNotifier(this._votePermissionService) : super(const ChainListState.loading()) {
    get();
  }

  Future<void> get() async {
    try {
      state = const ChainListState.loading();
      final response = await _votePermissionService.getSupportedChains(Empty());
      for (var element in response.chains) {
        print(element.denom);
      }
      state = ChainListState.loaded(chains: response.chains);
    } catch (e) {
      state = ChainListState.error(e.toString());
    }
  }
}

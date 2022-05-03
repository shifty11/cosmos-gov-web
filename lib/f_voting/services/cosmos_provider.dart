import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/f_voting/services/cosmos_service.dart';
import 'package:cosmos_gov_web/f_voting/services/state/cosmos_state.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final cosmosProvider = Provider<CosmosService>((ref) => CosmosService());

final cosmosProvider = StateNotifierProvider<CosmosStateNotifier, CosmosState>(
  (ref) => CosmosStateNotifier(CosmosService(), ref),
);

class CosmosStateNotifier extends StateNotifier<CosmosState> {
  final CosmosService _cosmosService;

  // final ProviderBase<AlwaysAliveProviderBase<VotePermissionListNotifier>> votePermissionListNotifier;
  StateNotifierProviderRef ref;

  String? _chainId;

  CosmosStateNotifier(this._cosmosService, this.ref) : super(const CosmosState.initial()) {
    _cosmosService.addListener(() {
      print("keystorage chagned");
      if (_chainId != null) {
        getAddress(_chainId!);
      }
    });
  }

  Future<String?> getAddress(String chainId) async {
    try {
      print("getAddress");
      final result = await _cosmosService.getAddress(chainId);
      if (result != null && result is String) {
        _chainId = chainId;
        print("connected: $result");
        state = CosmosState.connected(chainId: chainId, address: result);
        return result;
      } else {
        state = CosmosState.error(error: "unknown address for chain $chainId");
      }
    } on Exception catch (e) {
      state = CosmosState.error(error: e.toString());
    }
    return null;
  }

  grantVotePermission(VotePermission vp, int expiration) async {
    try {
      print("grantVotePermission");
      state = CosmosState.executing(chain: vp.chain);
      final result = await _cosmosService.grantVote(vp.chain.chainId, vp.chain.rpcAddress, vp.granter, vp.chain.grantee, expiration, vp.chain.denom);
      if (result == null) {
        print("null -> probalby aborted");
        state = CosmosState.error(error: "execution was aborted");
      } else if (result != null && result.transactionHash != null) {
        print("executed");
        state = CosmosState.executed(success: result.code == 0, txHash: result.transactionHash, rawLog: result.rawLog);
        if (result.code == 0) {
          await ref.read(votePermissionProvider).createVotePermission(CreateVotePermissionRequest(votePermission: vp));
          ref.read(votePermissionListStateProvider.notifier).get();
        }
      } else {
        state = CosmosState.error(error: "unknown result");
      }
    } on Exception catch (e) {
      state = CosmosState.error(error: e.toString());
    }
  }

  revokeVotePermission(VotePermission vp) async {
    try {
      print("revokeVotePermission");
      state = CosmosState.executing(chain: vp.chain);
      final result = await _cosmosService.revokeVote(vp.chain.chainId, vp.chain.rpcAddress, vp.granter, vp.chain.grantee);
      if (result == null) {
        print("null");
        state = CosmosState.error(error: "execution was aborted");
      } else if (result != null && result.transactionHash != null) {
        print("executed");
        state = CosmosState.executed(success: result.code == 0, txHash: result.transactionHash, rawLog: result.rawLog);
        if (result.code == 0) {
          await ref.read(votePermissionProvider).refreshVotePermission(RefreshVotePermissionRequest(votePermission: vp));
          ref.read(votePermissionListStateProvider.notifier).get();
        }
      } else {
        state = CosmosState.error(error: "unknown result");
      }
    } on Exception catch (e) {
      state = CosmosState.error(error: e.toString());
    }
  }
}

import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/f_voting/services/keplr_service.dart';
import 'package:cosmos_gov_web/f_voting/services/state/keplr_state.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final keplrProvider = StateNotifierProvider<KeplrStateNotifier, KeplrState>(
  (ref) => KeplrStateNotifier(KeplrService(), ref),
);

class KeplrStateNotifier extends StateNotifier<KeplrState> {
  final KeplrService _keplrService;

  StateNotifierProviderRef ref;

  String? _chainId;

  KeplrStateNotifier(this._keplrService, this.ref) : super(const KeplrState.initial()) {
    _keplrService.addListener(() {
      if (kDebugMode) {
        print("keystorage chagned");
      }
      if (_chainId != null) {
        getAddress(_chainId!);
      }
    });
  }

  Future<String?> getAddress(String chainId) async {
    try {
      if (kDebugMode) {
        print("getAddress");
      }
      final result = await _keplrService.getAddress(chainId);
      if (result != null && result is String) {
        _chainId = chainId;
        if (kDebugMode) {
          print("connected: $result");
        }
        state = KeplrState.connected(chainId: chainId, address: result);
        return result;
      } else {
        state = KeplrState.error(error: "unknown address for chain $chainId");
      }
    } on Exception catch (e) {
      state = KeplrState.error(error: e.toString());
    }
    return null;
  }

  grantVotePermission(VotePermission vp, int expiration) async {
    try {
      if (kDebugMode) {
        print("grantVotePermission");
      }
      state = KeplrState.executing(chain: vp.chain);
      final result = await _keplrService.grantVote(vp.chain.chainId, vp.chain.rpcAddress, vp.granter, vp.chain.grantee, expiration, vp.chain.denom);
      if (result == null) {
        if (kDebugMode) {
          print("null -> probalby aborted");
        }
        state = KeplrState.error(error: "execution was aborted");
      } else if (result != null && result.transactionHash != null) {
        if (kDebugMode) {
          print("executed");
        }
        state = KeplrState.executed(success: result.code == 0, txHash: result.transactionHash, rawLog: result.rawLog);
        if (result.code == 0) {
          await ref.read(votePermissionProvider).createVotePermission(CreateVotePermissionRequest(votePermission: vp));
          ref.read(votePermissionListStateProvider.notifier).get();
        }
      } else {
        state = KeplrState.error(error: "unknown result");
      }
    } on Exception catch (e) {
      state = KeplrState.error(error: e.toString());
    }
  }

  revokeVotePermission(VotePermission vp) async {
    try {
      if (kDebugMode) {
        print("revokeVotePermission");
      }
      state = KeplrState.executing(chain: vp.chain);
      final result = await _keplrService.revokeVote(vp.chain.chainId, vp.chain.rpcAddress, vp.granter, vp.chain.grantee);
      if (result == null) {
        if (kDebugMode) {
          print("null -> probalby aborted");
        }
        state = KeplrState.error(error: "execution was aborted");
      } else if (result != null && result.transactionHash != null) {
        if (kDebugMode) {
          print("executed");
        }
        state = KeplrState.executed(success: result.code == 0, txHash: result.transactionHash, rawLog: result.rawLog);
        if (result.code == 0) {
          await ref.read(votePermissionProvider).refreshVotePermission(RefreshVotePermissionRequest(votePermission: vp));
          ref.read(votePermissionListStateProvider.notifier).get();
        }
      } else {
        state = KeplrState.error(error: "unknown result");
      }
    } on Exception catch (e) {
      state = KeplrState.error(error: e.toString());
    }
  }
}

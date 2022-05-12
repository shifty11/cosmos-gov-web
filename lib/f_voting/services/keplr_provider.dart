import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_voting/services/keplr_service.dart';
import 'package:cosmos_gov_web/f_voting/services/state/keplr_tx_state.dart';
import 'package:cosmos_gov_web/f_voting/services/state/keplr_wallet_state.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final keplrTxProvider = StateNotifierProvider<KeplrStateNotifier, KeplrTxState>(
  (ref) => KeplrStateNotifier(KeplrService(), ref),
);

final keplrWalletProvider = StateProvider<KeplrWalletState>((ref) => const KeplrWalletState.initial());

class KeplrStateNotifier extends StateNotifier<KeplrTxState> {
  final KeplrService _keplrService;

  StateNotifierProviderRef ref;

  String? _chainId;

  KeplrStateNotifier(this._keplrService, this.ref) : super(const KeplrTxState.initial()) {
    _keplrService.addListener(() {
      if (cDebugMode) {
        print("keystorage chagned");
      }
      if (_chainId != null) {
        getAddress(_chainId!);
      }
    });
  }

  Future<String?> getAddress(String chainId) async {
    try {
      if (cDebugMode) {
        print("getAddress");
      }
      final result = await _keplrService.getAddress(chainId);
      if (result != null && result is String) {
        _chainId = chainId;
        if (cDebugMode) {
          print("connected: $result");
        }
        ref.watch(keplrWalletProvider.notifier).state = KeplrWalletState.connected(chainId: chainId, address: result);
        return result;
      } else {
        state = KeplrTxState.error(error: "unknown address for chain $chainId");
      }
    } on Exception catch (e) {
      state = KeplrTxState.error(error: e.toString());
    }
    return null;
  }

  grantVotePermission(VotePermission vp, int expiration) async {
    try {
      if (cDebugMode) {
        print("grantVotePermission");
      }
      state = KeplrTxState.executing(chain: vp.chain);
      final result =
          await _keplrService.grantVote(vp.chain, vp.granter, expiration);
      if (result == null) {
        if (cDebugMode) {
          print("null -> probalby aborted");
        }
        state = KeplrTxState.executed(success: false);
      } else if (result != null && result.transactionHash != null) {
        if (cDebugMode) {
          print("executed");
        }
        final info = "Added Vote Permission\nTransaction: ${result.transactionHash}";
        state = KeplrTxState.executed(success: result.code == 0, info: info);
        if (result.code == 0) {
          await ref.read(votePermissionProvider).createVotePermission(CreateVotePermissionRequest(votePermission: vp));
          ref.read(votePermissionListStateProvider.notifier).get();
        }
      } else {
        state = KeplrTxState.error(error: "unknown result");
      }
    } on Exception catch (e) {
      state = KeplrTxState.error(error: e.toString());
    }
  }

  revokeVotePermission(VotePermission vp) async {
    try {
      if (cDebugMode) {
        print("revokeVotePermission");
      }
      state = KeplrTxState.executing(chain: vp.chain);
      final result = await _keplrService.revokeVote(vp.chain, vp.granter);
      if (result == null) {
        if (cDebugMode) {
          print("null -> probalby aborted");
        }
        state = KeplrTxState.executed(success: false);
      } else if (result != null && result.transactionHash != null) {
        if (cDebugMode) {
          print("executed");
        }
        final info = "Removed Vote Permission\nTransaction: ${result.transactionHash}";
        state = KeplrTxState.executed(success: result.code == 0, info: info);
        if (result.code == 0) {
          await ref.read(votePermissionProvider).refreshVotePermission(RefreshVotePermissionRequest(votePermission: vp));
          ref.read(votePermissionListStateProvider.notifier).get();
        }
      } else {
        state = KeplrTxState.error(error: "unknown result");
      }
    } on Exception catch (e) {
      state = KeplrTxState.error(error: e.toString());
    }
  }
}

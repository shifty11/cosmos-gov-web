import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_voting/services/keplr_service.dart';
import 'package:cosmos_gov_web/f_voting/services/state/keplr_tx_state.dart';
import 'package:cosmos_gov_web/f_voting/services/state/keplr_wallet_state.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final keplrTxProvider = StateNotifierProvider<KeplrStateNotifier, KeplrTxState>(
      (ref) => KeplrStateNotifier(KeplrService(), ref),
);

final keplrWalletProvider = StateProvider<KeplrWalletState>((ref) => const KeplrWalletState.initial());

class KeplrStateNotifier extends StateNotifier<KeplrTxState> {
  final KeplrService _keplrService;
  final VotePermissionService _votePermissionService;

  final StateNotifierProviderRef _ref;

  String? _chainId;

  KeplrStateNotifier(this._keplrService, this._ref)
      : _votePermissionService = _ref.read(votePermissionProvider),
        super(const KeplrTxState.initial()) {
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
        _ref
            .watch(keplrWalletProvider.notifier)
            .state = KeplrWalletState.connected(chainId: chainId, address: result);
        return result;
      } else {
        state = KeplrTxState.error(error: "unknown address for chain $chainId");
      }
    } on Exception catch (e) {
      state = KeplrTxState.error(error: e.toString());
    }
    return null;
  }

  registerWallet(Chain chain) async {
    final address = await getAddress(chain.chainId);
    if (address == null) {
      return;
    }
    try {
      await _votePermissionService.registerWallet(RegisterWalletRequest(chainName: chain.name, walletAddress: address));
      _ref.refresh(walletListProvider);
    } on Exception catch (e) {
      state = KeplrTxState.error(error: e.toString());
    }
  }

  removeWallet(Wallet wallet) async {
    try {
      await _votePermissionService.removeWallet(RemoveWalletRequest(walletAddress: wallet.address));
      _ref.refresh(walletListProvider);
    } on Exception catch (e) {
      state = KeplrTxState.error(error: e.toString());
    }
  }

  bool _isValidResult(dynamic result) {
    if (result == null) {
      return false;
    }
    try {
      (result).code;
      (result).transactionHash;
      return true;
    } on NoSuchMethodError {
      return false;
    }
  }

  grantVotePermission(Wallet wallet) async {
    try {
      if (cDebugMode) {
        print("grantVotePermission");
      }
      final int secondsSinceEpoch = DateTime.now().toUtc().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;
      final expiration = secondsSinceEpoch + 7 * 24 * 60 * 60;

      state = KeplrTxState.executing(chain: wallet.chain);
      final result = await _keplrService.grantVote(wallet.chain, wallet.address, expiration);
      if (result == null) {
        if (cDebugMode) {
          print("null -> probably aborted");
        }
        state = KeplrTxState.executed(success: false);
      } else if (_isValidResult(result)) {
        if (cDebugMode) {
          print("executed");
        }
        final info = "Added Vote Permission\nTransaction: ${result.transactionHash}";
        state = KeplrTxState.executed(success: result.code == 0, info: info);
        // if (result.code == 0) {
        //   await _votePermissionService.refreshVotePermission(RefreshVotePermissionRequest(votePermission: vp));
        //   ref.read(votePermissionListStateProvider.notifier).get();
        // }
      } else {
        state = KeplrTxState.error(error: "unknown result");
      }
    } on Exception catch (e) {
      state = KeplrTxState.error(error: e.toString());
    }
    await _votePermissionService.refreshVotePermission(RefreshVotePermissionRequest(chainName: wallet.chain.name, granter: wallet.address, grantee: wallet.chain.grantee));
    _ref.refresh(walletListProvider);
  }

  revokeVotePermission(Wallet wallet) async {
    try {
      if (cDebugMode) {
        print("revokeVotePermission");
      }
      state = KeplrTxState.executing(chain: wallet.chain);
      final result = await _keplrService.revokeVote(wallet.chain, wallet.address);
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
          await _votePermissionService.refreshVotePermission(RefreshVotePermissionRequest(chainName: wallet.chain.name, granter: wallet.address, grantee: wallet.chain.grantee));
          _ref.refresh(walletListProvider);
        }
      } else {
        state = KeplrTxState.error(error: "unknown result");
      }
    } on Exception catch (e) {
      state = KeplrTxState.error(error: e.toString());
    }
  }
}

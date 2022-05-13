import 'package:cosmos_gov_web/api/protobuf/dart/admin_service.pb.dart';
import 'package:cosmos_gov_web/api/protobuf/dart/google/protobuf/empty.pb.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_admin/services/admin_service.dart';
import 'package:cosmos_gov_web/f_admin/services/message_provider.dart';
import 'package:cosmos_gov_web/f_admin/services/state/chain_state.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cosmos_gov_web/f_voting/services/chain_list_provider.dart' as subs_chain_list_provider;

final adminProvider = Provider<AdminService>((ref) => adminService);

final chainListStateProvider = FutureProvider<List<ChainSettings>>((ref) async {
  final adminService = ref.read(adminProvider);
  final response = await adminService.getChains(Empty());
  return response.chains;
});

final chainStateProvider = StateNotifierProvider.family<ChainNotifier, ChainState, int>(
  (ref, index) {
    final chain = ref.read(chainListStateProvider).value![index];
    return ChainNotifier(ref, chain);
  },
);

class ChainNotifier extends StateNotifier<ChainState> {
  final StateNotifierProviderRef _ref;
  ChainSettings _chain;

  ChainNotifier(this._ref, this._chain) : super(ChainState.loaded(chain: _chain));

  Future<void> _update(UpdateChainRequest update) async {
    try {
      final adminService = _ref.read(adminProvider);
      final response = await adminService.updateChain(update);
      _chain = response.chain;
      state = ChainState.loaded(chain: _chain);
      _ref.refresh(subs_chain_list_provider.chainListStateProvider);
      _ref.refresh(walletListProvider);
    } catch (e) {
      _ref.read(adminMsgProvider.notifier).sendMsg(error: e.toString());
    }
  }

  UpdateChainRequest _getNewUpdate() {
    return UpdateChainRequest(
      chainName: _chain.name,
      isEnabled: _chain.isEnabled,
      isVotingEnabled: _chain.isVotingEnabled,
      isFeegrantUsed: _chain.isFeegrantUsed,
    );
  }

  Future<void> setEnabled() async {
    _update(_getNewUpdate()..isEnabled = !_chain.isEnabled);
  }

  Future<void> setVotingEnabled() async {
    _update(_getNewUpdate()..isVotingEnabled = !_chain.isVotingEnabled);
  }

  Future<void> setFeegrantUsed() async {
    _update(_getNewUpdate()..isFeegrantUsed = !_chain.isFeegrantUsed);
  }
}

final searchChainProvider = StateProvider((ref) => "");

final chainProvider = StateProvider<ChainSettings?>((ref) => null);

final searchedChainProvider = Provider<List<int>>((ref) {
  final search = ref.watch(searchChainProvider).toLowerCase();
  final chainList = ref.watch(chainListStateProvider);
  return chainList.whenOrNull(data: (chains) {
        if (search.isEmpty) {
          return List.generate(chains.length, (index) => index);
        }
        return chains.asMap().entries.where((entry) => entry.value.displayName.toLowerCase().contains(search)).map((e) => e.key).toList();
      }) ??
      [];
});

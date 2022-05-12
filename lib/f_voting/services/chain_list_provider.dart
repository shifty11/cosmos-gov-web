import 'package:cosmos_gov_web/api/protobuf/dart/google/protobuf/empty.pb.dart';
import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pb.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chainListStateProvider = FutureProvider<List<Chain>>((ref) async {
  final votePermissionService = ref.read(votePermissionProvider);
  final response = await votePermissionService.getSupportedChains(Empty());
  ref.read(selectedChainProvider.notifier).state = response.chains.first;
  return response.chains;
});

final selectedChainProvider = StateProvider<Chain?>((ref) => null);

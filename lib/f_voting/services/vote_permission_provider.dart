import 'package:cosmos_gov_web/api/protobuf/dart/google/protobuf/empty.pb.dart';
import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pbgrpc.dart';
import 'package:cosmos_gov_web/config.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final votePermissionProvider = Provider<VotePermissionService>((ref) => votePermissionService);

final walletListProvider = FutureProvider<List<Wallet>>((ref) async {
  final votePermissionService = ref.read(votePermissionProvider);
  final response = await votePermissionService.getWallets(Empty());
  return response.wallets;
});

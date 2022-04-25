import 'package:cosmos_gov_web/api/protobuf/dart/vote_permission_service.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_connection_interface.dart';

class VotePermissionService extends VotePermissionServiceClient {
  static VotePermissionService? _singleton;

  factory VotePermissionService(ClientChannelBase channel, Iterable<ClientInterceptor> interceptors) =>
      _singleton ??= VotePermissionService._internal(channel, interceptors);

  VotePermissionService._internal(ClientChannelBase channel, Iterable<ClientInterceptor> interceptors)
      : super(channel, interceptors: interceptors);
}

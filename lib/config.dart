import 'package:cosmos_gov_web/f_admin/services/admin_service.dart';
import 'package:cosmos_gov_web/f_home/services/auth_interceptor.dart';
import 'package:cosmos_gov_web/f_home/services/auth_service.dart';
import 'package:cosmos_gov_web/f_home/services/jwt_manager.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_service.dart';
import 'package:cosmos_gov_web/f_voting/services/vote_permission_service.dart';
import 'package:flutter/foundation.dart';
import 'package:grpc/grpc_web.dart';

const refreshBeforeExpDuration = Duration(seconds: 10 * 60);

const uri = kReleaseMode ? 'https://app.decrypto.online' : 'http://test.mydomain.com:8080';

final channel = GrpcWebClientChannel.xhr(Uri.parse(uri));

final jwtManager = JwtManager();
final authInterceptor = AuthInterceptor(jwtManager);
final authService = AuthService(channel, [authInterceptor], jwtManager, refreshBeforeExpDuration);
final subsService = SubscriptionService(channel, [authInterceptor]);
final votePermissionService = VotePermissionService(channel, [authInterceptor]);
final adminService = AdminService(channel, [authInterceptor]);

class RouteData {
  final String name;
  final String path;

  const RouteData(this.name, this.path);
}

const rRoot = RouteData("root", "/");
const rUnauthenticated = RouteData("unauthenticated", "/login");
const rSubscriptions = RouteData("subscriptions", "/subscriptions");
const rVoting = RouteData("voting", "/voting");
const rAdmin = RouteData("admin", "/admin");

const bool cDebugMode = true;

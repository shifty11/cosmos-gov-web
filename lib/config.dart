import 'package:cosmos_gov_web/f_home/services/auth_interceptor.dart';
import 'package:cosmos_gov_web/f_home/services/auth_service.dart';
import 'package:cosmos_gov_web/f_home/services/jwt_manager.dart';
import 'package:cosmos_gov_web/f_subscription/services/subscription_service.dart';
import 'package:grpc/grpc_web.dart';

const refreshBeforeExpDuration = Duration(seconds: 235);

final channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:8080'));
final jwtManager = JwtManager();
final authInterceptor = AuthInterceptor(jwtManager);
final authService = AuthService(channel, [authInterceptor], jwtManager, refreshBeforeExpDuration);
final subsService = SubscriptionService(channel, [authInterceptor]);
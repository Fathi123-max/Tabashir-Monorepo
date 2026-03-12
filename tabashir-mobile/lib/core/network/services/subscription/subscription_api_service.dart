import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/subscription/subscription_response.dart';
import '../../models/subscription/subscription_debug_response.dart';

part 'subscription_api_service.g.dart';

/// Subscription API client
@RestApi(baseUrl: '/api/v1/mobile')
abstract class SubscriptionApiService {
  factory SubscriptionApiService(Dio dio) = _SubscriptionApiService;

  /// Get latest subscription info
  @GET('/subscription/latest')
  Future<HttpResponse<SubscriptionResponse>> getLatestSubscription();

  /// Debug subscription data
  @GET('/subscription/debug')
  Future<HttpResponse<SubscriptionDebugResponse>> debugSubscription();

  /// Test subscription endpoints
  @GET('/subscription/test')
  Future<HttpResponse<SubscriptionResponse>> testSubscription();
}

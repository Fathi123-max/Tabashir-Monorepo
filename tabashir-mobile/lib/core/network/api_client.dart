import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '_clients/dio_client.dart';
import '_clients/auth_dio_client.dart';
import '_clients/backend_dio_client.dart';
import 'services/index.dart';

/// Main API client that provides access to all API services
@singleton
class ApiClient {
  ApiClient(
    this._dioClient,
    this._authDioClient,
    this._backendDioClient,
  );

  final DioClient _dioClient;
  final AuthDioClient _authDioClient;
  final BackendDioClient _backendDioClient;

  /// Dio instance for custom requests
  Dio get dio => _dioClient.dio;

  /// Dio instance for authentication requests (localhost:5001)
  Dio get authDio => _authDioClient.dio;

  /// Dio instance for backend requests (backend.tabashir.ae)
  Dio get backendDio => _backendDioClient.dio;

  /// Tabashir API service for resume processing and job management
  late final TabashirApiService tabashirApiService = TabashirApiService(
    backendDio,
  );

  /// Authentication API service for login and register
  late final AuthApiService authApiService = AuthApiService(authDio);

  /// User management API service for profile and onboarding
  late final UserApiService userApiService = UserApiService(authDio);

  /// Subscription API service for subscription management
  late final SubscriptionApiService subscriptionApiService =
      SubscriptionApiService(authDio);

  /// Payment API service for payment processing
  late final PaymentApiService paymentApiService = PaymentApiService(authDio);

  /// File upload API service
  late final UploadApiService uploadApiService = UploadApiService(authDio);

  /// AI resume API service
  late final AiResumeApiService aiResumeApiService = AiResumeApiService(
    authDio,
  );

  /// Email API service
  late final EmailApiService emailApiService = EmailApiService(authDio);
}

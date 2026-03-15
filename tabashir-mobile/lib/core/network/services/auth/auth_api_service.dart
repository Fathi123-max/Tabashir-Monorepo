import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/auth/login_request.dart';
import '../../models/auth/register_request.dart';
import '../../models/auth/auth_response.dart';
import '../../models/auth/refresh_token_response.dart';

part 'auth_api_service.g.dart';

/// Authentication API client for Tabashir app
@RestApi(baseUrl: '/api/v1')
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  /// Login user with email and password
  @POST('/auth/login')
  Future<HttpResponse<AuthResponse>> login(
    @Body() LoginRequest loginRequest,
  );

  /// Register new user
  @POST('/auth/register')
  Future<HttpResponse<AuthResponse>> register(
    @Body() RegisterRequest registerRequest,
  );

  /// Refresh access token using refresh token
  @POST('/auth/refresh')
  Future<HttpResponse<RefreshTokenResponse>> refreshToken(
    @Body() Map<String, dynamic> request,
  );

  /// Sign in with Apple ID
  @POST('/auth/apple-signin')
  Future<HttpResponse<AuthResponse>> appleSignIn(
    @Body() Map<String, dynamic> request,
  );

  /// Delete user account
  @DELETE('/auth/account')
  Future<HttpResponse<Map<String, dynamic>>> deleteAccount();
}

/// Example usage of authentication API endpoints
///
/// This file demonstrates how to use the login and register endpoints
/// from the app.tabashir.ae API.
library;

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tabashir/core/network/api_client.dart';
import 'package:tabashir/core/network/models/auth/login_request.dart';
import 'package:tabashir/core/network/models/auth/register_request.dart';
import 'package:tabashir/core/error/dio_error_mapper.dart';
import 'package:tabashir/core/utils/app_logger.dart';

void main() async {
  // Get the API client from dependency injection
  final apiClient = GetIt.instance<ApiClient>();

  // Example 1: Login
  await loginExample(apiClient);

  // Example 2: Register
  await registerExample(apiClient);
}

Future<void> loginExample(ApiClient apiClient) async {
  try {
    // Create login request
    const loginRequest = LoginRequest(
      email: 'test-1@gmail.com',
      password: '123456@Test',
    );

    // Make login request
    final response = await apiClient.authApiService.login(
      loginRequest,
    );

    // Check response
    final authResponse = response.data;
    if (authResponse.success ?? true) {
      AppLogger.info('Login successful!', tag: 'AuthExample');
      AppLogger.info('Token: ${authResponse.token}', tag: 'AuthExample');
      AppLogger.info('User: ${authResponse.data?.name}', tag: 'AuthExample');
    } else {
      AppLogger.warning('Login failed: ${authResponse.message}', tag: 'AuthExample');
    }
  } on DioException catch (error) {
    final errorMessage = DioErrorMapper.mapDioError(error);
    AppLogger.error('Login error: $errorMessage', tag: 'AuthExample');

    // Log error to Crashlytics
    await DioErrorMapper.reportError(error);
  }
}

Future<void> registerExample(ApiClient apiClient) async {
  try {
    // Create register request
    const registerRequest = RegisterRequest(
      name: 'Test User',
      email: 'test-1@gmail.com',
      password: '123456@Test',
      userType: 'CANDIDATE',
    );

    // Make register request
    final response = await apiClient.authApiService.register(
      registerRequest,
    );

    // Check response
    final authResponse = response.data;
    if (authResponse.success ?? true) {
      AppLogger.info('Registration successful!', tag: 'AuthExample');
      AppLogger.info('User: ${authResponse.data?.name}', tag: 'AuthExample');
      AppLogger.info('Email: ${authResponse.data?.email}', tag: 'AuthExample');
    } else {
      AppLogger.warning('Registration failed: ${authResponse.message}', tag: 'AuthExample');
    }
  } on DioException catch (error) {
    final errorMessage = DioErrorMapper.mapDioError(error);
    AppLogger.error('Registration error: $errorMessage', tag: 'AuthExample');

    // Log error to Crashlytics
    await DioErrorMapper.reportError(error);
  }
}

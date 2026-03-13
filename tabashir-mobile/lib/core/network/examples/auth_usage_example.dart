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
      print('Login successful!');
      print('Token: ${authResponse.token}');
      print('User: ${authResponse.data?.name}');
    } else {
      print('Login failed: ${authResponse.message}');
    }
  } on DioException catch (error) {
    final errorMessage = DioErrorMapper.mapDioError(error);
    print('Login error: $errorMessage');

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
      print('Registration successful!');
      print('User: ${authResponse.data?.name}');
      print('Email: ${authResponse.data?.email}');
    } else {
      print('Registration failed: ${authResponse.message}');
    }
  } on DioException catch (error) {
    final errorMessage = DioErrorMapper.mapDioError(error);
    print('Registration error: $errorMessage');

    // Log error to Crashlytics
    await DioErrorMapper.reportError(error);
  }
}

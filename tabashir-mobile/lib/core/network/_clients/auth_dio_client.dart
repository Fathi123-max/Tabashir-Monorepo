import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../services/auth_session_service.dart';

/// Authentication Dio client with API token
/// Automatically adds user authentication token to requests
class AuthDioClient {
  AuthDioClient() {
    _dio = Dio(_getDefaultOptions());
    _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add the user's access token to the request headers
          final token = await AuthSessionService.instance.accessToken;
          print('[AUTH_DIO] Request to: ${options.uri}');
          print('[AUTH_DIO] Token available: ${token != null}');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            print('[AUTH_DIO] Added Authorization header');
          } else {
            print(
              '[AUTH_DIO] ⚠️ No token available - request will be unauthenticated',
            );
          }
          _logRequest(
            options.method,
            '${options.baseUrl}${options.path}',
            options.headers,
          );
          handler.next(options);
        },
        onResponse: (response, handler) async {
          _logResponse(response.statusCode, response.data);
          handler.next(response);
        },
        onError: (error, handler) async {
          final requestPath = error.requestOptions.path;
          print('[AUTH_DIO] ❌ Request to $requestPath failed: ${error.response?.statusCode}');
          
          if (error.response?.data != null) {
            print('[AUTH_DIO] Error response: ${error.response?.data}');
          }

          // Handle 401 Unauthorized errors
          if (error.response?.statusCode == 401) {
            print('[AUTH_DIO] 401 Unauthorized for path: $requestPath');

            // Check if this is an auth endpoint where 401 is expected or fatal
            final authEndpoints = [
              '/auth/login',
              '/auth/register',
              '/auth/refresh',
              '/auth/apple-signin',
            ];

            final isAuthEndpoint = authEndpoints.any(
              (path) => requestPath.contains(path),
            );

            // If it's a refresh endpoint itself that failed with 401, it's a fatal session expiry
            if (requestPath.contains('/auth/refresh')) {
              print('[AUTH_DIO] 401 on refresh endpoint - SESSION EXPIRED');
              await AuthSessionService.instance.setLoggedOut();
              return handler.next(error);
            }

            // If it's login/register, don't logout, just pass the error
            if (isAuthEndpoint) {
              print('[AUTH_DIO] 401 on login/register - No action needed');
              return handler.next(error);
            }

            // For non-auth endpoints, try to refresh the token
            print('[AUTH_DIO] Attempting token refresh...');
            try {
              final newToken =
                  await AuthSessionService.instance.refreshAccessToken();

              if (newToken != null) {
                print(
                  '[AUTH_DIO] Token refreshed successfully, retrying original request...',
                );

                // Clone the original request with the new token
                final opts = error.requestOptions;
                opts.headers['Authorization'] = 'Bearer $newToken';

                // Retry the request using the same Dio instance
                try {
                  final response = await _dio.fetch(opts);
                  return handler.resolve(response);
                } on DioException catch (retryError) {
                  print(
                    '[AUTH_DIO] ❌ Retry failed with error: ${retryError.message}',
                  );
                  return handler.next(retryError);
                }
              } else {
                print(
                  '[AUTH_DIO] ❌ Token refresh returned null (Unauthorized) - SESSION EXPIRED',
                );
                await AuthSessionService.instance.setLoggedOut();
              }
            } catch (e) {
              print('[AUTH_DIO] ❌ Token refresh failed with exception: $e');
              print('[AUTH_DIO] ⚠️ Network or server error - KEEPING SESSION ALIVE');
              // Don't call setLoggedOut() here for network errors
              // This allows the user to retry later when they have connection
              return handler.next(error);
            }
          }

          return handler.next(error);
        },
      ),
    );
  }
  late Dio _dio;

  BaseOptions _getDefaultOptions() {
    // Get API base URL from environment variable or use production URL as fallback
    // For local Flask development, use: http://10.0.2.2:5050
    final baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:5050';

    return BaseOptions(
      // Main backend URL for authentication, user management, payments, etc.
      // Uses environment variable for local development
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      // The default headers for the API client
      // In this case, we are setting the `Content-Type` to `application/json`.
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }

  void _logRequest(String method, String url, Map<String, dynamic>? headers) {
    print('\n========== [AUTH_DIO] API REQUEST ==========');
    print('Method: $method');
    print('URL: $url');
    print('Headers: $headers');
    print('===============================================\n');
  }

  void _logResponse(int? statusCode, dynamic data) {
    print('\n========== [AUTH_DIO] API RESPONSE ==========');
    print('Status: $statusCode');
    print('Data: $data');
    print('===============================================\n');
  }

  Dio get dio => _dio;
}

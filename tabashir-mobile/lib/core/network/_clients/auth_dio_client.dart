import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../services/auth_session_service.dart';
import '../../utils/app_logger.dart';

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
          AppLogger.debug('Request to: ${options.uri}', tag: 'AuthDio');
          AppLogger.debug('Token available: ${token != null}', tag: 'AuthDio');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            AppLogger.debug('Added Authorization header', tag: 'AuthDio');
          } else {
            AppLogger.warning(
              'No token available - request will be unauthenticated',
              tag: 'AuthDio',
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
          AppLogger.error(
            'Request to $requestPath failed: ${error.response?.statusCode}',
            tag: 'AuthDio',
          );

          if (error.response?.data != null) {
            AppLogger.debug('Error response: ${error.response?.data}', tag: 'AuthDio');
          }

          // Handle 401 Unauthorized errors
          if (error.response?.statusCode == 401) {
            AppLogger.debug('401 Unauthorized for path: $requestPath', tag: 'AuthDio');

            // Check if this is an auth endpoint where 401 is expected or fatal
            final authEndpoints = [
              '/auth/login',
              '/auth/register',
              '/auth/refresh',
              '/auth/apple-signin',
            ];

            final isAuthEndpoint = authEndpoints.any(
              requestPath.contains,
            );

            // If it's a refresh endpoint itself that failed with 401, it's a fatal session expiry
            if (requestPath.contains('/auth/refresh')) {
              AppLogger.warning('401 on refresh endpoint - SESSION EXPIRED', tag: 'AuthDio');
              await AuthSessionService.instance.setLoggedOut();
              return handler.next(error);
            }

            // If it's login/register, don't logout, just pass the error
            if (isAuthEndpoint) {
              AppLogger.debug('401 on login/register - No action needed', tag: 'AuthDio');
              return handler.next(error);
            }

            // For non-auth endpoints, try to refresh the token
            AppLogger.debug('Attempting token refresh...', tag: 'AuthDio');
            try {
              final newToken = await AuthSessionService.instance
                  .refreshAccessToken();

              if (newToken != null) {
                AppLogger.debug(
                  'Token refreshed successfully, retrying original request...',
                  tag: 'AuthDio',
                );

                // Clone the original request with the new token
                final opts = error.requestOptions;
                opts.headers['Authorization'] = 'Bearer $newToken';

                // Retry the request using the same Dio instance
                try {
                  final response = await _dio.fetch(opts);
                  return handler.resolve(response);
                } on DioException catch (retryError) {
                  AppLogger.error(
                    'Retry failed with error: ${retryError.message}',
                    tag: 'AuthDio',
                  );
                  return handler.next(retryError);
                }
              } else {
                AppLogger.warning(
                  'Token refresh returned null (Unauthorized) - SESSION EXPIRED',
                  tag: 'AuthDio',
                );
                await AuthSessionService.instance.setLoggedOut();
              }
            } catch (e) {
              AppLogger.error('Token refresh failed with exception: $e', tag: 'AuthDio');
              AppLogger.warning(
                'Network or server error - KEEPING SESSION ALIVE',
                tag: 'AuthDio',
              );
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
    AppLogger.debug('\nAPI REQUEST - Method: $method, URL: $url, Headers: $headers', tag: 'AuthDio');
  }

  void _logResponse(int? statusCode, dynamic data) {
    AppLogger.debug('\nAPI RESPONSE - Status: $statusCode, Data: $data', tag: 'AuthDio');
  }

  Dio get dio => _dio;
}

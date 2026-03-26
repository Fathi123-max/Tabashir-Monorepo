import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tabashir/core/services/auth_session_service.dart';

/// Backend Dio client for backend.tabashir.ae API
/// Adds user authentication token to requests but no x-api-token
/// Used for resume processing and job management endpoints
class BackendDioClient {
  BackendDioClient() {
    _dio = Dio(_getDefaultOptions());
    _dio.interceptors.add(LogInterceptor());
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add the user's access token to the request headers
          final token = await AuthSessionService.instance.accessToken;
          print('[BACKEND_DIO] Request to: ${options.uri}');
          print('[BACKEND_DIO] Token available: ${token != null}');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
            print('[BACKEND_DIO] Added Authorization header');
          } else {
            print(
              '[BACKEND_DIO] ⚠️ No token available - request will be unauthenticated',
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
          print(
            '[BACKEND_DIO] ❌ Request to $requestPath failed: ${error.response?.statusCode}',
          );

          if (error.response?.data != null) {
            print('[BACKEND_DIO] Error response: ${error.response?.data}');
          }

          // Handle 401 Unauthorized errors
          if (error.response?.statusCode == 401) {
            print('[BACKEND_DIO] 401 Unauthorized for path: $requestPath');

            // If it's a refresh endpoint itself that failed with 401, it's a fatal session expiry
            if (requestPath.contains('/auth/refresh')) {
              print('[BACKEND_DIO] 401 on refresh endpoint - SESSION EXPIRED');
              await AuthSessionService.instance.setLoggedOut();
              return handler.next(error);
            }

            // For non-auth endpoints, try to refresh the token
            print('[BACKEND_DIO] Attempting token refresh...');
            try {
              final newToken = await AuthSessionService.instance
                  .refreshAccessToken();

              if (newToken != null) {
                print(
                  '[BACKEND_DIO] Token refreshed successfully, retrying original request...',
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
                    '[BACKEND_DIO] ❌ Retry failed with error: ${retryError.message}',
                  );
                  return handler.next(retryError);
                }
              } else {
                print(
                  '[BACKEND_DIO] ❌ Token refresh returned null (Unauthorized) - SESSION EXPIRED',
                );
                await AuthSessionService.instance.setLoggedOut();
              }
            } catch (e) {
              print('[BACKEND_DIO] ❌ Token refresh failed with exception: $e');
              print(
                '[BACKEND_DIO] ⚠️ Network or server error - KEEPING SESSION ALIVE',
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

  BaseOptions _getDefaultOptions() => BaseOptions(
    // Base URL is loaded from .env
    baseUrl: dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:5050',
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    sendTimeout: const Duration(seconds: 120),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  void _logRequest(String method, String url, Map<String, dynamic>? headers) {
    print('\n========== [BACKEND_DIO] API REQUEST ==========');
    print('Method: $method');
    print('URL: $url');
    print('Headers: $headers');
    print('===============================================\n');
  }

  void _logResponse(int? statusCode, dynamic data) {
    print('\n========== [BACKEND_DIO] API RESPONSE ==========');
    print('Status: $statusCode');
    print('Data: $data');
    print('===============================================\n');
  }

  Dio get dio => _dio;
}

import 'package:dio/dio.dart';
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
          print(
            '[BACKEND_DIO] ❌ Request failed: ${error.response?.statusCode}',
          );
          if (error.response?.data != null) {
            print('[BACKEND_DIO] Error response: ${error.response?.data}');
          }
          _logResponse(error.response?.statusCode, error.response?.data);
          // Handle 401 Unauthorized errors
          if (error.response?.statusCode == 401) {
            final requestPath = error.requestOptions.path.toLowerCase();
            print('[BACKEND_DIO] 401 Unauthorized for path: $requestPath');

            // Check if this is an auth endpoint
            // For auth endpoints (/mobile/auth/login, /mobile/auth/register), 401 means invalid credentials - clear state
            final authEndpoints = [
              '/mobile/auth/login',
              '/mobile/auth/register',
              '/mobile/auth/refresh',
            ];

            final isAuthEndpoint = authEndpoints.any(
              (endpoint) => requestPath.contains(endpoint),
            );

            if (isAuthEndpoint) {
              print('[BACKEND_DIO] 401 on auth endpoint - Clearing auth state');
              await AuthSessionService.instance.setLoggedOut();
              handler.next(error);
              return;
            }

            // For non-auth endpoints, try to refresh the token
            print(
              '[BACKEND_DIO] 401 on non-auth endpoint - Attempting token refresh',
            );
            try {
              final newToken = await AuthSessionService.instance
                  .refreshAccessToken();
              if (newToken != null) {
                print(
                  '[BACKEND_DIO] Token refreshed successfully - Retrying request',
                );

                // Clone the original request with the new token
                final opts = error.requestOptions;
                opts.headers['Authorization'] = 'Bearer $newToken';

                // Retry the request
                final clonedRequest = await _dio.fetch(opts);
                handler.resolve(clonedRequest);
                return;
              }
            } catch (e) {
              print('[BACKEND_DIO] Token refresh failed: $e');
            }

            // If refresh failed, clear auth state
            print('[BACKEND_DIO] Token refresh failed - Clearing auth state');
            await AuthSessionService.instance.setLoggedOut();
          }
          handler.next(error);
        },
      ),
    );
  }
  late Dio _dio;

  BaseOptions _getDefaultOptions() => BaseOptions(
    // External resume/jobs backend URL
    // For local development with Flask, use:
    baseUrl: 'http://localhost:5001/api/v1/resume',
    // Production:
    // baseUrl: 'https://backend.tabashir.ae/api/v1/resume',
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    sendTimeout: const Duration(seconds: 120),
    headers: {
      'Content-Type': 'application/json',
      'X-API-TOKEN':
          'a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5',
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

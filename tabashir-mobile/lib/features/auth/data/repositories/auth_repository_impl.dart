import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/_config/api_config.dart';
import 'package:tabashir/core/network/models/auth/auth_response.dart';
import 'package:tabashir/core/network/models/auth/email_verification_request.dart';
import 'package:tabashir/core/network/models/auth/login_request.dart';
import 'package:tabashir/core/network/models/auth/register_request.dart';
import 'package:tabashir/core/network/models/auth/email_verification_response.dart';
import 'package:tabashir/core/network/services/auth/auth_api_service.dart';
import 'package:tabashir/core/network/services/auth/email_api_service.dart';
import 'package:tabashir/core/utils/app_logger.dart';
import 'package:tabashir/features/auth/domain/repositories/auth_repository.dart';

/// Implementation of [AuthRepository]
/// Handles authentication operations using [AuthApiService] and [EmailApiService]
@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authApiService, this._emailApiService);

  final AuthApiService _authApiService;
  final EmailApiService _emailApiService;

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequest(
        email: email,
        password: password,
      );

      final response = await _authApiService.login(
        request,
      );

      // Debug: Log the raw response
      AppLogger.debug('Raw response data: ${response.response.data}', tag: 'Auth');
      AppLogger.debug('Parsed AuthResponse: ${response.data}', tag: 'Auth');
      AppLogger.debug(
        '- accessToken in response.data: ${response.data.accessToken != null ? "present" : "NULL"}',
        tag: 'Auth',
      );
      AppLogger.debug(
        '- refreshToken in response.data: ${response.data.refreshToken != null ? "present" : "NULL"}',
        tag: 'Auth',
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Login failed with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String name,
    String userType = 'CANDIDATE', // Default to CANDIDATE
  }) async {
    try {
      final request = RegisterRequest(
        name: name,
        email: email,
        password: password,
        userType: userType,
      );

      final response = await _authApiService.register(
        request,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Registration failed with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  @override
  Future<EmailVerificationResponse> verifyEmail({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _emailApiService.verifyEmail(
        email,
        code,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Email verification failed with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Email verification failed: $e');
    }
  }

  @override
  Future<EmailVerificationResponse> sendVerificationEmail({
    required String email,
  }) async {
    try {
      final request = EmailVerificationRequest(email: email);
      final response = await _emailApiService.sendVerificationEmail(request);

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Send verification email failed with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Send verification email failed: $e');
    }
  }

  @override
  Future<AuthResponse> appleSignIn({
    required String identityToken,
    String? email,
    String? givenName,
    String? familyName,
  }) async {
    try {
      // Call Apple Sign-In API endpoint
      final request = <String, dynamic>{
        'identityToken': identityToken,
      };

      if (email != null) request['email'] = email;

      if (givenName != null || familyName != null) {
        request['fullName'] = {
          'givenName': ?givenName,
          'familyName': ?familyName,
        };
      }

      final response = await _authApiService.appleSignIn(
        request,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Apple sign-in failed with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Apple sign-in failed: $e');
    }
  }

  @override
  Future<AuthResponse> googleSignIn({
    required String idToken,
    String? email,
    String? name,
  }) async {
    try {
      // Call Google Sign-In API endpoint
      final request = <String, dynamic>{
        'idToken': idToken,
      };

      if (email != null) request['email'] = email;
      if (name != null) request['name'] = name;

      final response = await _authApiService.googleSignIn(
        request,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Google sign-in failed with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Google sign-in failed: $e');
    }
  }

  /// Handle Dio errors and convert to meaningful exceptions
  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        // Try to extract error message from various possible response structures
        var message = 'Request failed';
        try {
          if (e.response?.data != null) {
            final data = e.response!.data;
            if (data is Map<String, dynamic>) {
              // Try common error message fields
              message =
                  data['message']?.toString() ??
                  data['error']?.toString() ??
                  data['error_message']?.toString() ??
                  'Request failed';
            } else if (data is String) {
              message = data;
            }
          }
        } catch (_) {
          // If we can't parse the error, use a generic message
          message = 'Request failed';
        }

        // Handle specific status codes
        switch (statusCode) {
          case 400:
            return Exception('$message (Status: $statusCode)');
          case 401:
            return Exception('Unauthorized. Please log in again.');
          case 403:
            return Exception("Access forbidden. You don't have permission.");
          case 404:
            return Exception('Resource not found.');
          case 409:
            // 409 Conflict - typically means email/user already exists
            return Exception(
              'An account with this email already exists. Please use a different email or try logging in.',
            );
          case 422:
            return Exception('Invalid data: $message');
          case 429:
            return Exception('Too many requests. Please try again later.');
          case 500:
            return Exception('Server error. Please try again later.');
          case 502:
            return Exception('Bad gateway. Please try again later.');
          case 503:
            return Exception('Service unavailable. Please try again later.');
          case 504:
            return Exception('Gateway timeout. Please try again later.');
          default:
            return Exception('$message (Status: $statusCode)');
        }
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      default:
        return Exception('An unexpected error occurred: ${e.message}');
    }
  }
}

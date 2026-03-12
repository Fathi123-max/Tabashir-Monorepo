import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Maps Dio errors to application-specific errors
class DioErrorMapper {
  /// Maps DioError to a user-friendly message
  static String mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return 'Bad request. Please check your input.';
          case 401:
            return 'Unauthorized. Please log in again.';
          case 403:
            return "Access forbidden. You don't have permission.";
          case 404:
            return 'Resource not found.';
          case 429:
            return 'Too many requests. Please try again later.';
          case 500:
            return 'Server error. Please try again later.';
          case 502:
            return 'Bad gateway. Please try again later.';
          case 503:
            return 'Service unavailable. Please try again later.';
          case 504:
            return 'Gateway timeout. Please try again later.';
          default:
            return 'Server error (${error.response?.statusCode}). Please try again.';
        }
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.badCertificate:
        return 'Certificate error. Please contact support.';
      case DioExceptionType.connectionError:
        return 'Connection error. Please check your internet connection.';
      case DioExceptionType.unknown:
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }

  /// Reports error to Crashlytics
  static Future<void> reportError(DioException error) async {
    await FirebaseCrashlytics.instance.recordError(
      error,
      StackTrace.current,
      reason: 'Dio error occurred',
    );
  }
}

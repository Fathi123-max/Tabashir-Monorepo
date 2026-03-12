import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/subscription/subscription_response.dart';
import 'package:tabashir/core/network/models/subscription/subscription_debug_response.dart';
import 'package:tabashir/core/network/services/subscription/subscription_api_service.dart';
import 'package:tabashir/features/subscription/domain/repositories/subscription_repository.dart';

/// Implementation of [SubscriptionRepository]
/// Handles subscription operations using [SubscriptionApiService]
@Injectable(as: SubscriptionRepository)
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._subscriptionApiService);

  final SubscriptionApiService _subscriptionApiService;

  @override
  Future<SubscriptionResponse> getLatestSubscription() async {
    try {
      final response = await _subscriptionApiService.getLatestSubscription();

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to get subscription with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to get subscription: $e');
    }
  }

  @override
  Future<SubscriptionDebugResponse> debugSubscription() async {
    try {
      final response = await _subscriptionApiService.debugSubscription();

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to get debug subscription with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to get debug subscription: $e');
    }
  }

  @override
  Future<SubscriptionResponse> testSubscription() async {
    try {
      final response = await _subscriptionApiService.testSubscription();

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to test subscription with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to test subscription: $e');
    }
  }

  /// Handle Dio errors and convert to meaningful exceptions
  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case final DioExceptionType receiveTimeout:
        return Exception('Connection timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Request failed';
        return Exception('$message (Status: $statusCode)');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      default:
        return Exception('An unexpected error occurred: ${e.message}');
    }
  }
}

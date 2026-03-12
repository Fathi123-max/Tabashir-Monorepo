import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_request.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_response.dart';
import 'package:tabashir/core/network/models/payment/checkout_session_request.dart';
import 'package:tabashir/core/network/models/payment/checkout_session_response.dart';
import 'package:tabashir/core/network/models/payment/latest_payment_response.dart';
import 'package:tabashir/core/network/services/payment/payment_api_service.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_repository.dart';

/// Implementation of [PaymentRepository]
/// Handles payment operations using [PaymentApiService]
@Injectable(as: PaymentRepository)
class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRepositoryImpl(this._paymentApiService);

  final PaymentApiService _paymentApiService;

  @override
  Future<PaymentIntentResponse> createPaymentIntent({
    required PaymentIntentRequest request,
  }) async {
    try {
      final response = await _paymentApiService.createPaymentIntent(
        request,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to create payment intent with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to create payment intent: $e');
    }
  }

  @override
  Future<CheckoutSessionResponse> createCheckoutSession({
    required CheckoutSessionRequest request,
  }) async {
    try {
      final response = await _paymentApiService.createCheckoutSession(
        request,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to create checkout session with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to create checkout session: $e');
    }
  }

  @override
  Future<LatestPaymentResponse> getLatestPayment() async {
    try {
      final response = await _paymentApiService.getLatestPayment();

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to get latest payment with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to get latest payment: $e');
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

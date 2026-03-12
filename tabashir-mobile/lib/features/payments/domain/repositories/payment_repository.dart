import 'package:tabashir/core/network/models/payment/payment_intent_request.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_response.dart';
import 'package:tabashir/core/network/models/payment/checkout_session_request.dart';
import 'package:tabashir/core/network/models/payment/checkout_session_response.dart';
import 'package:tabashir/core/network/models/payment/latest_payment_response.dart';

/// Repository interface for payment operations
/// Defines the contract for payment data operations
abstract class PaymentRepository {
  /// Create payment intent
  /// Returns [PaymentIntentResponse] with payment intent details
  Future<PaymentIntentResponse> createPaymentIntent({
    required PaymentIntentRequest request,
  });

  /// Create Stripe checkout session
  /// Returns [CheckoutSessionResponse] with session URL and details
  Future<CheckoutSessionResponse> createCheckoutSession({
    required CheckoutSessionRequest request,
  });

  /// Get latest payment information
  /// Returns [LatestPaymentResponse] with payment details
  Future<LatestPaymentResponse> getLatestPayment();
}

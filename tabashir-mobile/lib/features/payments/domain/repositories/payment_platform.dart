import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/repositories/apple_payment_platform.dart' show ApplePaymentPlatform;
import '../../data/repositories/stripe_payment_platform.dart' show StripePaymentPlatform;

part 'payment_platform.freezed.dart';

/// Abstract interface for payment processing.
/// Implementations: [StripePaymentPlatform] (Android), [ApplePaymentPlatform] (iOS).
abstract class PaymentPlatform {
  /// Process a payment for the given service.
  ///
  /// [serviceId] — e.g. 'ai-job-apply-basic'
  /// [amount] — price in AED
  /// [userId] — authenticated user ID
  /// [resumeId] — optional, required for ai-resume-optimization
  ///
  /// Returns a [PaymentResult] with success/cancelled/failed state.
  Future<PaymentResult> processPayment({
    required String serviceId,
    required double amount,
    required String userId,
    String? resumeId,
  });
}

/// Result of a payment attempt.
@freezed
class PaymentResult with _$PaymentResult {
  const factory PaymentResult.success({String? transactionId}) = _PaymentSuccess;
  const factory PaymentResult.cancelled() = _PaymentCancelled;
  const factory PaymentResult.failed(String message) = _PaymentFailed;
}

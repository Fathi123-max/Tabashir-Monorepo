import 'package:tabashir/core/network/models/payment/payment_intent_request.dart';
import 'package:tabashir/core/services/stripe_service.dart' as stripe_svc;
import 'package:tabashir/features/payments/domain/repositories/payment_platform.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_repository.dart';

/// Stripe implementation of [PaymentPlatform] for Android.
class StripePaymentPlatform implements PaymentPlatform {
  /// Creates a new [StripePaymentPlatform] with the given service and repository.
  StripePaymentPlatform(this._stripeService, this._repository);

  final stripe_svc.StripeService _stripeService;
  final PaymentRepository _repository;

  @override
  Future<PaymentResult> processPayment({
    required String serviceId,
    required double amount,
    required String userId,
    String? resumeId,
  }) async {
    try {
      final request = PaymentIntentRequest(
        amount: amount,
        currency: 'AED',
        serviceId: serviceId,
        userId: userId,
        resumeId: resumeId,
      );

      final response = await _repository.createPaymentIntent(
        request: request,
      );
      final data = response.data;

      if (data == null) {
        return const PaymentResult.failed(
          'No payment data returned from server',
        );
      }

      _stripeService.setPublishableKey(data.publishableKey ?? '');

      await _stripeService.initPaymentSheet(
        customerId: data.customer ?? '',
        customerEphemeralKeySecret: data.ephemeralKey ?? '',
        paymentIntentClientSecret: data.clientSecret ?? '',
        merchantDisplayName: 'Tabashir',
      );

      await Future<void>.delayed(const Duration(milliseconds: 300));
      final result = await _stripeService.processPayment();

      if (result.success) {
        return PaymentResult.success(
          transactionId: data.paymentIntentId,
        );
      } else if (result.canceled) {
        return const PaymentResult.cancelled();
      } else {
        return PaymentResult.failed(result.message);
      }
    } on Exception catch (e) {
      return PaymentResult.failed(e.toString());
    }
  }
}

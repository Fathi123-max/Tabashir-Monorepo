import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tabashir/core/services/apple_iap_service.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_platform.dart';

/// iOS payment platform implementation using StoreKit 2.
class ApplePaymentPlatform implements PaymentPlatform {
  /// Creates an instance with the given IAP service.
  ApplePaymentPlatform(this._appleService);

  final AppleIAPService _appleService;

  @override
  Future<PaymentResult> processPayment({
    required String serviceId,
    required double amount,
    required String userId,
    String? resumeId,
  }) async {
    // 1. Initialize IAP
    final available = await _appleService.init();
    if (!available) {
      return const PaymentResult.failed('App Store payments not available');
    }

    // 2. Fetch product details
    final products = await _appleService.getProducts({serviceId});
    if (products.isEmpty) {
      return PaymentResult.failed('Product $serviceId not found in App Store');
    }

    final product = products.first;

    // 3. Listen for purchase updates using Completer pattern
    final completer = Completer<PaymentResult>();
    late final StreamSubscription<PurchaseDetails> sub;

    sub = _appleService.purchaseStream.listen((purchase) async {
      if (purchase.productID != serviceId) {
        return;
      }

      switch (purchase.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // 4. Verify with backend
          final transactionId = purchase.purchaseID ??
              'fallback_${purchase.transactionDate?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch}_'
                  '${DateTime.now().microsecondsSinceEpoch}';
          final verification = await _appleService.verifyReceipt(
            transactionId: transactionId,
            productId: serviceId,
            userId: userId,
            resumeId: resumeId,
          );

          if (verification.success) {
            await _appleService.completePurchase(purchase);
            completer.complete(
              PaymentResult.success(transactionId: verification.paymentId),
            );
          } else {
            completer.complete(
              PaymentResult.failed(
                'Receipt verification failed: ${verification.error}',
              ),
            );
          }
          await sub.cancel();

        case PurchaseStatus.error:
          completer.complete(
            PaymentResult.failed(
              purchase.error?.message ?? 'Purchase failed',
            ),
          );
          await sub.cancel();

        case PurchaseStatus.pending:
          // Still processing — don't complete yet
          break;

        case PurchaseStatus.canceled:
          completer.complete(const PaymentResult.cancelled());
          await sub.cancel();
      }
    });

    // 5. Initiate purchase
    await _appleService.purchase(product);

    // 6. Wait for result (with timeout)
    try {
      return await completer.future.timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          unawaited(sub.cancel());
          return const PaymentResult.failed('Payment timed out');
        },
      );
    } on TimeoutException {
      return const PaymentResult.failed('Payment timed out');
    } on Exception catch (e) {
      unawaited(sub.cancel());
      return PaymentResult.failed(e.toString());
    }
  }
}

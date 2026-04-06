import 'dart:async';

import 'package:dio/dio.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'package:tabashir/core/utils/app_logger.dart';

/// Service for handling Apple In-App Purchases (StoreKit 2).
class AppleIAPService {

  /// Creates an instance with the given Dio client.
  AppleIAPService(this._dio);
  final InAppPurchase _iap = InAppPurchase.instance;
  final Dio _dio;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  final _purchaseController = StreamController<PurchaseDetails>.broadcast();

  /// Stream of purchase details updates.
  Stream<PurchaseDetails> get purchaseStream => _purchaseController.stream;

  /// Initialize IAP connection and start listening for purchase updates.
  Future<bool> init() async {
    final available = await _iap.isAvailable();
    if (!available) {
      AppLogger.error('[AppleIAP] Store not available', tag: 'Payments');
      return false;
    }

    _subscription = _iap.purchaseStream.listen(
      (purchaseDetailsList) {
        purchaseDetailsList.forEach(_purchaseController.add);
      },
      onDone: () => _subscription?.cancel(),
      onError: (Object error) {
        AppLogger.error(
          '[AppleIAP] Stream error: $error',
          tag: 'Payments',
        );
      },
    );

    return true;
  }

  /// Fetch product details from App Store Connect.
  Future<List<ProductDetails>> getProducts(Set<String> productIds) async {
    final response = await _iap.queryProductDetails(productIds);
    if (response.notFoundIDs.isNotEmpty) {
      AppLogger.warning(
        '[AppleIAP] Products not found: ${response.notFoundIDs}',
        tag: 'Payments',
      );
    }
    return response.productDetails;
  }

  /// Initiate a purchase.
  /// The actual payment flow is handled by the purchaseStream.
  Future<void> purchase(ProductDetails product) async {
    final param = PurchaseParam(productDetails: product);
    await _iap.buyConsumable(purchaseParam: param);
  }

  /// Verify the purchase receipt with the backend.
  /// POST /api/v1/payments/verify-apple-receipt
  Future<PaymentVerificationResult> verifyReceipt({
    required String transactionId,
    required String productId,
    required String userId,
    String? resumeId,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/api/v1/payments/verify-apple-receipt',
        data: {
          'transactionId': transactionId,
          'productId': productId,
          'userId': userId,
          'resumeId': resumeId,
        },
      );
      final data = response.data?['data'] as Map<String, dynamic>?;
      return PaymentVerificationResult(
        success: response.data?['success'] == true,
        paymentId: data?['paymentId'] as String?,
      );
    } on DioException catch (e) {
      AppLogger.error(
        '[AppleIAP] Receipt verification failed: $e',
        tag: 'Payments',
      );
      return const PaymentVerificationResult(
        success: false,
        error: 'Receipt verification failed',
      );
    }
  }

  /// Mark a purchase as completed (consumes it so it can be purchased again).
  Future<void> completePurchase(PurchaseDetails purchase) async {
    await _iap.completePurchase(purchase);
  }

  /// Restore previous purchases (for user account recovery).
  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  /// Dispose of resources when no longer needed.
  void dispose() {
    _subscription?.cancel();
    unawaited(_purchaseController.close());
  }
}

/// Result of payment receipt verification.
class PaymentVerificationResult {
  /// Creates a verification result.
  const PaymentVerificationResult({
    required this.success,
    this.paymentId,
    this.error,
  });

  /// Whether the verification was successful.
  final bool success;

  /// The payment ID returned from the backend (if successful).
  final String? paymentId;

  /// Error message (if verification failed).
  final String? error;
}

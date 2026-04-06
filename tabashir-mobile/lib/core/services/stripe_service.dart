import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tabashir/core/utils/app_logger.dart';

// import '../constants/stripe_constants.dart';

/// Service for handling Stripe payment operations
/// Provides methods for PaymentSheet, CardField, and native payment methods
class StripeService {
  StripeService() {
    _initializeStripe();
  }

  /// Initialize Stripe with publishable key from environment
  Future<void> _initializeStripe() async {
    try {
      final publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'];
      if (publishableKey == null || publishableKey.isEmpty) {
        AppLogger.warning(
          'Stripe publish key not found in environment variables',
          tag: 'Service',
        );
        return;
      }

      Stripe.publishableKey = publishableKey;

      // Optional: Set merchant identifier for Apple Pay
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        await Stripe.instance.applySettings();
      }
      
      AppLogger.info('Stripe initialized successfully', tag: 'Service');
    } catch (e) {
      AppLogger.error('Error initializing Stripe: $e', tag: 'Service');
      rethrow;
    }
  }

  /// Set publishable key dynamically
  void setPublishableKey(String key) {
    Stripe.publishableKey = key;
  }

  /// Initialize Payment Sheet
  /// This method must be called before presenting the payment sheet
  /// It creates a payment intent on your server and prepares the payment sheet
  Future<void> initPaymentSheet({
    required String customerId,
    required String customerEphemeralKeySecret,
    required String paymentIntentClientSecret,
    required String merchantDisplayName,
    String? setupIntentClientSecret,
    String? merchantCountryCode = 'US',
    bool allowDelayedPaymentMethods = true,
    PaymentSheetApplePay? applePay,
    PaymentSheetGooglePay? googlePay,
  }) async {
    try {
      final parameters = SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        setupIntentClientSecret: setupIntentClientSecret,
        merchantDisplayName: merchantDisplayName,
        customerId: customerId,
        customerEphemeralKeySecret: customerEphemeralKeySecret,
        // Enable all automatic payment methods
        allowsDelayedPaymentMethods: allowDelayedPaymentMethods,
        applePay: applePay,
        googlePay: googlePay,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: parameters,
      );
    } catch (e) {
      AppLogger.debug('Error initializing payment sheet: $e', tag: 'Service');
      rethrow;
    }
  }

  /// Present payment sheet and process payment
  /// Returns [PaymentResult] indicating success or failure
  Future<PaymentResult> processPayment() async {
    try {
      // Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      // If we reach here, the payment sheet was completed successfully
      // confirmPaymentSheetPayment() is handled internally by the SDK
      return PaymentResult.success(
        message: 'Payment successful',
      );
    } on StripeException catch (e) {
      final errorCode = e.error.code;
      final errorMessage = e.error.message?.toLowerCase() ?? '';
      if (errorCode == 'Canceled' ||
          (errorCode == 'Failed' && errorMessage.contains('cancel'))) {
        return PaymentResult.canceled(
          message: 'Payment was canceled',
        );
      }
      return PaymentResult.failed(
        message: e.error.message ?? 'Payment failed',
      );
    } catch (e) {
      return PaymentResult.failed(
        message: 'An unexpected error occurred: $e',
      );
    }
  }

  /// Confirm payment with card details
  /// Use this for custom payment flows
  Future<PaymentResult> confirmPayment({
    required String paymentIntentClientSecret,
    required PaymentMethodParams paymentMethodData,
  }) async {
    try {
      final paymentIntent = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: paymentIntentClientSecret,
        data: paymentMethodData,
      );

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        return PaymentResult.success(
          message: 'Payment successful',
        );
      } else if (paymentIntent.status == PaymentIntentsStatus.Canceled) {
        return PaymentResult.canceled(
          message: 'Payment was canceled',
        );
      } else if (paymentIntent.status == PaymentIntentsStatus.RequiresAction) {
        // 3D Secure or other authentication required
        return PaymentResult.requiresAction(
          message: 'Authentication required',
        );
      } else {
        return PaymentResult.failed(
          message: 'Payment failed: ${paymentIntent.status}',
        );
      }
    } on StripeException catch (e) {
      return PaymentResult.failed(
        message: e.error.message ?? 'Payment failed',
      );
    } catch (e) {
      return PaymentResult.failed(
        message: 'An unexpected error occurred: $e',
      );
    }
  }

  /// Create a payment method from card details
  Future<PaymentMethod> createPaymentMethod({
    required PaymentMethodParams params,
  }) async {
    try {
      return await Stripe.instance.createPaymentMethod(
        params: params,
      );
    } catch (e) {
      AppLogger.debug('Error creating payment method: $e', tag: 'Service');
      rethrow;
    }
  }

  /// Check if Platform Pay is available
  Future<bool> isPlatformPaySupported() async {
    try {
      return await Stripe.instance.isPlatformPaySupported();
    } catch (e) {
      AppLogger.debug('Error checking Platform Pay availability: $e', tag: 'Service');
      return false;
    }
  }

  /// Process Apple Pay payment using Platform Pay
  Future<PaymentResult> processApplePay({
    required String clientSecret,
    required ApplePayParams applePayParams,
  }) async {
    try {
      final paymentIntent = await Stripe.instance
          .confirmPlatformPayPaymentIntent(
            clientSecret: clientSecret,
            confirmParams: PlatformPayConfirmParams.applePay(
              applePay: applePayParams,
            ),
          );

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        return PaymentResult.success(
          message: 'Apple Pay payment successful',
        );
      } else if (paymentIntent.status == PaymentIntentsStatus.Canceled) {
        return PaymentResult.canceled(
          message: 'Apple Pay was canceled',
        );
      } else {
        return PaymentResult.failed(
          message: 'Apple Pay failed: ${paymentIntent.status}',
        );
      }
    } on StripeException catch (e) {
      return PaymentResult.failed(
        message: e.error.message ?? 'Apple Pay failed',
      );
    } catch (e) {
      return PaymentResult.failed(
        message: 'An unexpected error occurred: $e',
      );
    }
  }

  /// Process Google Pay payment using Platform Pay
  Future<PaymentResult> processGooglePay({
    required String clientSecret,
    required GooglePayParams googlePayParams,
  }) async {
    try {
      final paymentIntent = await Stripe.instance
          .confirmPlatformPayPaymentIntent(
            clientSecret: clientSecret,
            confirmParams: PlatformPayConfirmParams.googlePay(
              googlePay: googlePayParams,
            ),
          );

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        return PaymentResult.success(
          message: 'Google Pay payment successful',
        );
      } else if (paymentIntent.status == PaymentIntentsStatus.Canceled) {
        return PaymentResult.canceled(
          message: 'Google Pay was canceled',
        );
      } else {
        return PaymentResult.failed(
          message: 'Google Pay failed: ${paymentIntent.status}',
        );
      }
    } on StripeException catch (e) {
      return PaymentResult.failed(
        message: e.error.message ?? 'Google Pay failed',
      );
    } catch (e) {
      return PaymentResult.failed(
        message: 'An unexpected error occurred: $e',
      );
    }
  }

  /// Reset payment sheet customer data
  void resetPaymentSheet() {
    try {
      Stripe.instance.resetPaymentSheetCustomer();
    } catch (e) {
      AppLogger.debug('Error resetting payment sheet: $e', tag: 'Service');
    }
  }

  /// Dispose and cleanup
  void dispose() {
    // Cleanup if needed
  }
}

/// Payment result model
class PaymentResult {
  const PaymentResult._({
    required this.success,
    required this.canceled,
    required this.requiresAction,
    required this.message,
  });

  factory PaymentResult.success({required String message}) => PaymentResult._(
    success: true,
    canceled: false,
    requiresAction: false,
    message: message,
  );

  factory PaymentResult.canceled({required String message}) => PaymentResult._(
    success: false,
    canceled: true,
    requiresAction: false,
    message: message,
  );

  factory PaymentResult.failed({required String message}) => PaymentResult._(
    success: false,
    canceled: false,
    requiresAction: false,
    message: message,
  );

  factory PaymentResult.requiresAction({
    required String message,
  }) => PaymentResult._(
    success: false,
    canceled: false,
    requiresAction: true,
    message: message,
  );
  final bool success;
  final bool canceled;
  final bool requiresAction;
  final String message;
}

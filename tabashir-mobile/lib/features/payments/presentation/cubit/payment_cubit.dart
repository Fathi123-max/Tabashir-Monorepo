import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/models/stripe/payment_sheet_config.dart';
import 'package:tabashir/core/models/stripe/stripe_payment_method.dart';
import 'package:tabashir/core/models/stripe/stripe_enums.dart';
import 'package:tabashir/core/network/models/payment/checkout_session_request.dart';
import 'package:tabashir/core/network/models/payment/checkout_session_response.dart';
import 'package:tabashir/core/network/models/payment/latest_payment_response.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_request.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_response.dart';
import 'package:tabashir/core/services/stripe_service.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_repository.dart';

part 'payment_state.dart';
part 'payment_cubit.freezed.dart';
part 'payment_cubit.g.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(
    this._repository,
    this._stripeService,
  ) : super(const PaymentState());

  final PaymentRepository _repository;
  final StripeService _stripeService;

  /// Create payment intent
  Future<void> createPaymentIntent({
    required PaymentIntentRequest request,
  }) async {
    emit(
      state.copyWith(
        status: PaymentStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final response = await _repository.createPaymentIntent(request: request);

      final paymentData = response.data;
      if (paymentData != null) {
        // 1. Set Publishable Key dynamically from backend
        if (paymentData.publishableKey != null) {
          _stripeService.setPublishableKey(paymentData.publishableKey!);
        }

        // 2. Initialize Payment Sheet
        await _stripeService.initPaymentSheet(
          customerId: paymentData.customer ?? '',
          customerEphemeralKeySecret: paymentData.ephemeralKey ?? '',
          paymentIntentClientSecret: paymentData.clientSecret ?? '',
          merchantDisplayName: 'Tabashir',
        );

        emit(
          state.copyWith(
            status: PaymentStatus.success,
            paymentIntent: response,
            paymentSheetInitialized: true,
          ),
        );
      } else {
        throw Exception('Payment data is null');
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Create checkout session
  Future<void> createCheckoutSession({
    required CheckoutSessionRequest request,
  }) async {
    emit(
      state.copyWith(
        status: PaymentStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final response = await _repository.createCheckoutSession(
        request: request,
      );

      emit(
        state.copyWith(
          status: PaymentStatus.success,
          checkoutSession: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Load latest payment
  Future<void> loadLatestPayment() async {
    emit(
      state.copyWith(
        status: PaymentStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final response = await _repository.getLatestPayment();

      emit(
        state.copyWith(
          status: PaymentStatus.success,
          latestPayment: response,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear error
  void clearError() {
    emit(
      state.copyWith(
        errorMessage: '',
        status: PaymentStatus.initial,
      ),
    );
  }

  /// Reset to initial state
  void reset() {
    _stripeService.resetPaymentSheet();
    emit(const PaymentState());
  }

  // ========== Stripe Payment Sheet Methods ==========

  /// Initialize Stripe Payment Sheet
  Future<void> initPaymentSheet({
    required String customerId,
    required String customerEphemeralKeySecret,
    required String paymentIntentClientSecret,
    required String merchantDisplayName,
    String? setupIntentClientSecret,
    String merchantCountryCode = 'US',
    bool allowDelayedPaymentMethods = true,
    PaymentSheetApplePay? applePay,
    PaymentSheetGooglePay? googlePay,
  }) async {
    emit(
      state.copyWith(
        status: PaymentStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      await _stripeService.initPaymentSheet(
        customerId: customerId,
        customerEphemeralKeySecret: customerEphemeralKeySecret,
        paymentIntentClientSecret: paymentIntentClientSecret,
        setupIntentClientSecret: setupIntentClientSecret,
        merchantDisplayName: merchantDisplayName,
        merchantCountryCode: merchantCountryCode,
        allowDelayedPaymentMethods: allowDelayedPaymentMethods,
        applePay: applePay,
        googlePay: googlePay,
      );

      emit(
        state.copyWith(
          status: PaymentStatus.success,
          paymentSheetInitialized: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: 'Failed to initialize payment sheet: $e',
        ),
      );
    }
  }

  /// Process payment using Payment Sheet
  Future<void> processPaymentSheet() async {
    emit(
      state.copyWith(
        status: PaymentStatus.processing,
        errorMessage: '',
      ),
    );

    try {
      final result = await _stripeService.processPayment();

      if (result.success) {
        emit(
          state.copyWith(
            status: PaymentStatus.success,
            paymentSuccessful: true,
          ),
        );
      } else if (result.canceled) {
        emit(
          state.copyWith(
            status: PaymentStatus.canceled,
            paymentSuccessful: false,
          ),
        );
      } else if (result.requiresAction) {
        emit(
          state.copyWith(
            status: PaymentStatus.requiresAction,
            errorMessage: result.message,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: PaymentStatus.failed,
            errorMessage: result.message,
            paymentSuccessful: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: 'Payment failed: $e',
          paymentSuccessful: false,
        ),
      );
    }
  }

  // ========== Native Payment Methods ==========

  /// Check if Apple Pay is available
  Future<bool> isApplePayAvailable() async {
    try {
      return await _stripeService.isPlatformPaySupported();
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: 'Failed to check Apple Pay availability: $e',
        ),
      );
      return false;
    }
  }

  /// Process Apple Pay payment
  Future<void> processApplePay({
    required String clientSecret,
    required String merchantCountryCode,
    required String currencyCode,
    required List<ApplePayCartSummaryItem> items,
  }) async {
    emit(
      state.copyWith(
        status: PaymentStatus.processing,
        errorMessage: '',
      ),
    );

    try {
      final result = await _stripeService.processApplePay(
        clientSecret: clientSecret,
        applePayParams: ApplePayParams(
          merchantCountryCode: merchantCountryCode,
          currencyCode: currencyCode,
          cartItems: items,
        ),
      );

      if (result.success) {
        emit(
          state.copyWith(
            status: PaymentStatus.success,
            paymentSuccessful: true,
          ),
        );
      } else if (result.canceled) {
        emit(
          state.copyWith(
            status: PaymentStatus.canceled,
            paymentSuccessful: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: PaymentStatus.failed,
            errorMessage: result.message,
            paymentSuccessful: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: 'Apple Pay failed: $e',
          paymentSuccessful: false,
        ),
      );
    }
  }

  /// Check if Google Pay is available
  Future<bool> isGooglePayAvailable() async {
    try {
      return await _stripeService.isPlatformPaySupported();
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: 'Failed to check Google Pay availability: $e',
        ),
      );
      return false;
    }
  }

  /// Process Google Pay payment
  Future<void> processGooglePay({
    required String clientSecret,
    required bool testEnv,
    required String countryCode,
  }) async {
    emit(
      state.copyWith(
        status: PaymentStatus.processing,
        errorMessage: '',
      ),
    );

    try {
      final result = await _stripeService.processGooglePay(
        clientSecret: clientSecret,
        googlePayParams: GooglePayParams(
          testEnv: testEnv,
          merchantCountryCode: countryCode,
          currencyCode: 'USD', // Default currency
        ),
      );

      if (result.success) {
        emit(
          state.copyWith(
            status: PaymentStatus.success,
            paymentSuccessful: true,
          ),
        );
      } else if (result.canceled) {
        emit(
          state.copyWith(
            status: PaymentStatus.canceled,
            paymentSuccessful: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: PaymentStatus.failed,
            errorMessage: result.message,
            paymentSuccessful: false,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: PaymentStatus.failed,
          errorMessage: 'Google Pay failed: $e',
          paymentSuccessful: false,
        ),
      );
    }
  }
}

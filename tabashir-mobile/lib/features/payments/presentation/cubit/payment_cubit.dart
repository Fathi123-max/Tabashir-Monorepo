import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/models/stripe/stripe_enums.dart';
import 'package:tabashir/core/models/stripe/payment_sheet_config.dart';
import 'package:tabashir/core/models/stripe/stripe_payment_method.dart';
import 'package:tabashir/core/network/models/payment/checkout_session_request.dart';
import 'package:tabashir/core/network/models/payment/checkout_session_response.dart';
import 'package:tabashir/core/network/models/payment/latest_payment_response.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_request.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_response.dart';
import 'package:tabashir/core/services/stripe_service.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';

part 'payment_state.dart';
part 'payment_cubit.freezed.dart';
part 'payment_cubit.g.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(
    this._repository,
    this._stripeService,
    this._profileCubit,
  ) : super(const PaymentState());

  final PaymentRepository _repository;
  final StripeService _stripeService;
  final ProfileCubit _profileCubit;

  /// Callback fired after successful payment.
  /// Set this before calling createPaymentIntent to handle navigation
  /// from a screen that may have been disposed during the payment sheet.
  Function(PaymentIntentResponse? paymentIntent)? onPaymentSuccess;

  /// Get the current user ID from profile cubit
  /// Throws an exception if user ID is not available
  String get _currentUserId {
    final userId = _profileCubit.currentUserId;
    if (userId == null || userId.isEmpty) {
      throw Exception(
        'User ID not available. Please ensure you are logged in.',
      );
    }
    return userId;
  }

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
      // Add userId to the request
      final requestWithUser = request.copyWith(userId: _currentUserId);

      final response = await _repository.createPaymentIntent(
        request: requestWithUser,
      );

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

        // 3. Present the payment sheet automatically after a short delay
        await Future.delayed(const Duration(milliseconds: 300));

        try {
          final paymentResult = await _stripeService.processPayment();

          // 4. Handle payment result
          if (paymentResult.success) {
            // Refresh profile data to get updated job_matching and jobs_to_apply_number
            try {
              await _profileCubit.loadProfileData(force: true);
              print('[PaymentCubit] Profile refreshed after successful payment');
              
              // Also refresh HomeCubit to update the UI with new job credits
              try {
                final homeCubit = getIt<HomeCubit>();
                final email = _profileCubit.state.profile?.email;
                if (email != null && email.isNotEmpty) {
                  await homeCubit.loadAiEnhancedHomeData(email: email);
                  print('[PaymentCubit] HomeCubit refreshed with new job credits');
                }
              } catch (homeErr) {
                print('[PaymentCubit] Failed to refresh HomeCubit: $homeErr');
              }
            } catch (profileErr) {
              print('[PaymentCubit] Failed to refresh profile: $profileErr');
              // Don't fail the payment if profile refresh fails
            }

            emit(
              state.copyWith(
                status: PaymentStatus.success,
                paymentSuccessful: true,
                paymentSheetInitialized: false,
              ),
            );

            // Fire callback for screens that may have been disposed
            // during the payment sheet presentation
            onPaymentSuccess?.call(state.paymentIntent);
            onPaymentSuccess = null; // Clear to prevent double-firing
          } else if (paymentResult.canceled) {
            emit(
              state.copyWith(
                status: PaymentStatus.canceled,
                paymentSuccessful: false,
                paymentSheetInitialized: false,
                errorMessage: 'Payment was canceled',
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: PaymentStatus.failed,
                paymentSuccessful: false,
                paymentSheetInitialized: false,
                errorMessage: paymentResult.message,
              ),
            );
          }
        } catch (e) {
          emit(
            state.copyWith(
              status: PaymentStatus.failed,
              paymentSuccessful: false,
              paymentSheetInitialized: false,
              errorMessage: 'Payment processing failed: $e',
            ),
          );
        }
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
        // Refresh profile data to get updated job_matching and jobs_to_apply_number
        try {
          await _profileCubit.loadProfileData(force: true);
          print('[PaymentCubit] Profile refreshed after payment sheet success');
          
          // Also refresh HomeCubit to update the UI with new job credits
          try {
            final homeCubit = getIt<HomeCubit>();
            final email = _profileCubit.state.profile?.email;
            if (email != null && email.isNotEmpty) {
              await homeCubit.loadAiEnhancedHomeData(email: email);
              print('[PaymentCubit] HomeCubit refreshed with new job credits');
            }
          } catch (homeErr) {
            print('[PaymentCubit] Failed to refresh HomeCubit: $homeErr');
          }
        } catch (profileErr) {
          print('[PaymentCubit] Failed to refresh profile: $profileErr');
        }

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

part of 'payment_cubit.dart';

@freezed
sealed class PaymentState with _$PaymentState {
  const factory PaymentState({
    @Default(PaymentStatus.initial) PaymentStatus status,
    @Default('') String errorMessage,
    PaymentIntentResponse? paymentIntent,
    CheckoutSessionResponse? checkoutSession,
    LatestPaymentResponse? latestPayment,
    @Default(false) bool paymentSheetInitialized,
    @Default(false) bool paymentSuccessful,
  }) = _PaymentState;
}

// Note: Using PaymentStatus from stripe_enums.dart for consistency
// Old status values mapped:
// - initial -> initial
// - loading -> loading
// - paymentIntentCreated -> success
// - checkoutSessionCreated -> success
// - latestPaymentLoaded -> success
// - error -> failed

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/models/stripe/stripe_enums.dart';
import 'package:tabashir/core/network/models/payment/checkout_session_response.dart';
import 'package:tabashir/core/network/models/payment/latest_payment_response.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_response.dart';
import 'package:tabashir/core/utils/app_logger.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_platform.dart';
import 'package:tabashir/features/payments/domain/repositories/payment_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';

part 'payment_state.dart';
part 'payment_cubit.freezed.dart';

@injectable
class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(
    this._platform,
    this._profileCubit,
  ) : super(const PaymentState());

  final PaymentPlatform _platform;
  final ProfileCubit _profileCubit;

  /// Callback fired after successful payment.
  /// Set this before calling processPayment to handle navigation.
  Future<void> Function(PaymentResult)? onPaymentSuccess;

  /// Process a payment — works for both Stripe (Android) and Apple IAP (iOS).
  Future<void> processPayment({
    required String serviceId,
    required double amount,
    String? resumeId,
  }) async {
    final userId = _currentUserId;

    emit(state.copyWith(
      status: PaymentStatus.loading,
      errorMessage: '',
    ));

    try {
      final result = await _platform.processPayment(
        serviceId: serviceId,
        amount: amount,
        userId: userId,
        resumeId: resumeId,
      );

      result.when(
        success: (transactionId) => _handlePaymentSuccess(result),
        cancelled: () => _handlePaymentCancelled(),
        failed: (message) => _handlePaymentFailed(message),
      );
    } on Exception catch (e) {
      emit(state.copyWith(
        status: PaymentStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Get the current user ID from profile cubit.
  String get _currentUserId {
    final userId = _profileCubit.currentUserId;
    if (userId == null || userId.isEmpty) {
      throw Exception(
        'User ID not available. Please ensure you are logged in.',
      );
    }
    return userId;
  }

  Future<void> _refreshAfterPayment() async {
    try {
      await _profileCubit.loadProfileData(force: true);
      AppLogger.debug(
        '[PaymentCubit] Profile refreshed after payment',
        tag: 'Payments',
      );

      try {
        final homeCubit = getIt<HomeCubit>();
        final email = _profileCubit.state.profile?.email;
        if (email != null && email.isNotEmpty) {
          await homeCubit.loadAiEnhancedHomeData(email: email);
          AppLogger.debug(
            '[PaymentCubit] HomeCubit refreshed with new credits',
            tag: 'Payments',
          );
        }
      } on Exception catch (homeErr) {
        AppLogger.error(
          '[PaymentCubit] Failed to refresh HomeCubit: $homeErr',
          tag: 'Payments',
          error: homeErr,
        );
      }
    } on Exception catch (profileErr) {
      AppLogger.error(
        '[PaymentCubit] Failed to refresh profile: $profileErr',
        tag: 'Payments',
        error: profileErr,
      );
    }
  }

  Future<void> _handlePaymentSuccess(PaymentResult result) async {
    await _refreshAfterPayment();
    emit(state.copyWith(
      status: PaymentStatus.success,
      paymentSuccessful: true,
    ));
    await onPaymentSuccess?.call(result);
    onPaymentSuccess = null;
  }

  void _handlePaymentCancelled() {
    emit(state.copyWith(
      status: PaymentStatus.canceled,
      errorMessage: 'Payment was canceled',
    ));
  }

  void _handlePaymentFailed(String message) {
    emit(state.copyWith(
      status: PaymentStatus.failed,
      errorMessage: message,
    ));
  }

  /// Load latest payment (kept for backwards compatibility).
  Future<void> loadLatestPayment() async {
    emit(state.copyWith(
      status: PaymentStatus.loading,
      errorMessage: '',
    ));
    try {
      final response = await getIt<PaymentRepository>().getLatestPayment();
      emit(state.copyWith(
        status: PaymentStatus.success,
        latestPayment: response,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: PaymentStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Clear error.
  void clearError() {
    emit(state.copyWith(
      errorMessage: '',
      status: PaymentStatus.initial,
    ));
  }

  /// Reset to initial state.
  void reset() {
    emit(const PaymentState());
  }
}

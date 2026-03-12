import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_session_response.freezed.dart';
part 'checkout_session_response.g.dart';

/// Checkout session response model
@freezed
sealed class CheckoutSessionResponse with _$CheckoutSessionResponse {
  const factory CheckoutSessionResponse({
    required bool success,
    String? message,
    CheckoutSessionData? data,
  }) = _CheckoutSessionResponse;

  factory CheckoutSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutSessionResponseFromJson(json);
}

/// Checkout session data
@freezed
sealed class CheckoutSessionData with _$CheckoutSessionData {
  const factory CheckoutSessionData({
    String? sessionId,
    String? url,
    String? paymentIntentId,
  }) = _CheckoutSessionData;

  factory CheckoutSessionData.fromJson(Map<String, dynamic> json) =>
      _$CheckoutSessionDataFromJson(json);
}

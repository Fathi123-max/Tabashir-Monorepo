import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_session_request.freezed.dart';
part 'checkout_session_request.g.dart';

/// Checkout session request model
@freezed
sealed class CheckoutSessionRequest with _$CheckoutSessionRequest {
  const factory CheckoutSessionRequest({
    required String plan,
    double? amount,
    String? currency,
    String? userId,
    String? successUrl,
    String? cancelUrl,
  }) = _CheckoutSessionRequest;

  factory CheckoutSessionRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutSessionRequestFromJson(json);
}

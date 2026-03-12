import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_intent_response.freezed.dart';
part 'payment_intent_response.g.dart';

/// Payment intent response model
@freezed
sealed class PaymentIntentResponse with _$PaymentIntentResponse {
  const factory PaymentIntentResponse({
    required bool success,
    String? message,
    PaymentIntentData? data,
  }) = _PaymentIntentResponse;

  factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentResponseFromJson(json);
}

/// Payment intent data
@freezed
sealed class PaymentIntentData with _$PaymentIntentData {
  const factory PaymentIntentData({
    String? clientSecret,
    String? paymentIntentId,
    double? amount,
    String? currency,
    String? status,
  }) = _PaymentIntentData;

  factory PaymentIntentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentDataFromJson(json);
}

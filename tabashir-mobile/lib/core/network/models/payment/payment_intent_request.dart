import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_intent_request.freezed.dart';
part 'payment_intent_request.g.dart';

/// Payment intent request model
@freezed
sealed class PaymentIntentRequest with _$PaymentIntentRequest {
  const factory PaymentIntentRequest({
    required double amount,
    String? currency,
    String? plan,
    String? userId,
  }) = _PaymentIntentRequest;

  factory PaymentIntentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntentRequestFromJson(json);
}

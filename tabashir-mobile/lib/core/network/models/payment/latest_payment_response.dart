import 'package:freezed_annotation/freezed_annotation.dart';

part 'latest_payment_response.freezed.dart';
part 'latest_payment_response.g.dart';

/// Latest payment response model
@freezed
sealed class LatestPaymentResponse with _$LatestPaymentResponse {
  const factory LatestPaymentResponse({
    required bool success,
    String? message,
    LatestPaymentData? data,
  }) = _LatestPaymentResponse;

  factory LatestPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$LatestPaymentResponseFromJson(json);
}

/// Latest payment data
@freezed
sealed class LatestPaymentData with _$LatestPaymentData {
  const factory LatestPaymentData({
    String? id,
    String? subscriptionId,
    double? amount,
    String? currency,
    String? status,
    String? paymentMethod,
    String? transactionId,
    String? paymentDate,
    String? createdAt,
    String? updatedAt,
  }) = _LatestPaymentData;

  factory LatestPaymentData.fromJson(Map<String, dynamic> json) =>
      _$LatestPaymentDataFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_response.freezed.dart';
part 'subscription_response.g.dart';

/// Subscription response model
@freezed
sealed class SubscriptionResponse with _$SubscriptionResponse {
  const factory SubscriptionResponse({
    required bool success,
    String? message,
    SubscriptionData? data,
  }) = _SubscriptionResponse;

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResponseFromJson(json);
}

/// Subscription data based on Prisma schema
@freezed
sealed class SubscriptionData with _$SubscriptionData {
  const factory SubscriptionData({
    required String id,
    String? userId,
    String? plan,
    String? status,
    String? startDate,
    String? endDate,
    bool? autoRenew,
    double? paymentAmount,
    String? paymentDate,
    String? createdAt,
    String? updatedAt,
  }) = _SubscriptionData;

  factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDataFromJson(json);
}

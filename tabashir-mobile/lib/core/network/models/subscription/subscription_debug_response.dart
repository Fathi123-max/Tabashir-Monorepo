import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_debug_response.freezed.dart';
part 'subscription_debug_response.g.dart';

/// Subscription debug response model
@freezed
sealed class SubscriptionDebugResponse with _$SubscriptionDebugResponse {
  const factory SubscriptionDebugResponse({
    required bool success,
    String? message,
    SubscriptionDebugData? data,
  }) = _SubscriptionDebugResponse;

  factory SubscriptionDebugResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDebugResponseFromJson(json);
}

/// Subscription debug data
@freezed
sealed class SubscriptionDebugData with _$SubscriptionDebugData {
  const factory SubscriptionDebugData({
    String? subscriptionId,
    String? plan,
    String? status,
    String? startDate,
    String? endDate,
    String? autoRenew,
    Map<String, dynamic>? metadata,
    String? createdAt,
    String? updatedAt,
  }) = _SubscriptionDebugData;

  factory SubscriptionDebugData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDebugDataFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_debug_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionDebugResponse _$SubscriptionDebugResponseFromJson(
  Map<String, dynamic> json,
) => _SubscriptionDebugResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : SubscriptionDebugData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SubscriptionDebugResponseToJson(
  _SubscriptionDebugResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_SubscriptionDebugData _$SubscriptionDebugDataFromJson(
  Map<String, dynamic> json,
) => _SubscriptionDebugData(
  subscriptionId: json['subscriptionId'] as String?,
  plan: json['plan'] as String?,
  status: json['status'] as String?,
  startDate: json['startDate'] as String?,
  endDate: json['endDate'] as String?,
  autoRenew: json['autoRenew'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$SubscriptionDebugDataToJson(
  _SubscriptionDebugData instance,
) => <String, dynamic>{
  'subscriptionId': instance.subscriptionId,
  'plan': instance.plan,
  'status': instance.status,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'autoRenew': instance.autoRenew,
  'metadata': instance.metadata,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

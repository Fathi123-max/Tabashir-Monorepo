// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubscriptionResponse _$SubscriptionResponseFromJson(
  Map<String, dynamic> json,
) => _SubscriptionResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : SubscriptionData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SubscriptionResponseToJson(
  _SubscriptionResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_SubscriptionData _$SubscriptionDataFromJson(Map<String, dynamic> json) =>
    _SubscriptionData(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      plan: json['plan'] as String?,
      status: json['status'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      autoRenew: json['autoRenew'] as bool?,
      paymentAmount: (json['paymentAmount'] as num?)?.toDouble(),
      paymentDate: json['paymentDate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$SubscriptionDataToJson(_SubscriptionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'plan': instance.plan,
      'status': instance.status,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'autoRenew': instance.autoRenew,
      'paymentAmount': instance.paymentAmount,
      'paymentDate': instance.paymentDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

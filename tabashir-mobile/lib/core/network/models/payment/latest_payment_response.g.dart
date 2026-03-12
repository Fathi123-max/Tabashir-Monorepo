// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LatestPaymentResponse _$LatestPaymentResponseFromJson(
  Map<String, dynamic> json,
) => _LatestPaymentResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : LatestPaymentData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LatestPaymentResponseToJson(
  _LatestPaymentResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_LatestPaymentData _$LatestPaymentDataFromJson(Map<String, dynamic> json) =>
    _LatestPaymentData(
      id: json['id'] as String?,
      subscriptionId: json['subscriptionId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      status: json['status'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      transactionId: json['transactionId'] as String?,
      paymentDate: json['paymentDate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$LatestPaymentDataToJson(_LatestPaymentData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subscriptionId': instance.subscriptionId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
      'paymentMethod': instance.paymentMethod,
      'transactionId': instance.transactionId,
      'paymentDate': instance.paymentDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

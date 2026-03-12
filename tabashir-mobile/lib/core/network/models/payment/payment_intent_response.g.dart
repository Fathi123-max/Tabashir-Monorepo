// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentIntentResponse _$PaymentIntentResponseFromJson(
  Map<String, dynamic> json,
) => _PaymentIntentResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : PaymentIntentData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PaymentIntentResponseToJson(
  _PaymentIntentResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_PaymentIntentData _$PaymentIntentDataFromJson(Map<String, dynamic> json) =>
    _PaymentIntentData(
      clientSecret: json['clientSecret'] as String?,
      paymentIntentId: json['paymentIntentId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PaymentIntentDataToJson(_PaymentIntentData instance) =>
    <String, dynamic>{
      'clientSecret': instance.clientSecret,
      'paymentIntentId': instance.paymentIntentId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': instance.status,
    };

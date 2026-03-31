// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_intent_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentIntentRequest _$PaymentIntentRequestFromJson(
  Map<String, dynamic> json,
) => _PaymentIntentRequest(
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String?,
  plan: json['plan'] as String?,
  userId: json['userId'] as String?,
  serviceId: json['serviceId'] as String?,
  resumeId: json['resumeId'] as String?,
);

Map<String, dynamic> _$PaymentIntentRequestToJson(
  _PaymentIntentRequest instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'currency': instance.currency,
  'plan': instance.plan,
  'userId': instance.userId,
  'serviceId': instance.serviceId,
  'resumeId': instance.resumeId,
};

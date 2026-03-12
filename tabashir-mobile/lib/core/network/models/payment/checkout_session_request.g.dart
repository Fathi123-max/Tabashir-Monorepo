// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_session_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckoutSessionRequest _$CheckoutSessionRequestFromJson(
  Map<String, dynamic> json,
) => _CheckoutSessionRequest(
  plan: json['plan'] as String,
  amount: (json['amount'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  userId: json['userId'] as String?,
  successUrl: json['successUrl'] as String?,
  cancelUrl: json['cancelUrl'] as String?,
);

Map<String, dynamic> _$CheckoutSessionRequestToJson(
  _CheckoutSessionRequest instance,
) => <String, dynamic>{
  'plan': instance.plan,
  'amount': instance.amount,
  'currency': instance.currency,
  'userId': instance.userId,
  'successUrl': instance.successUrl,
  'cancelUrl': instance.cancelUrl,
};

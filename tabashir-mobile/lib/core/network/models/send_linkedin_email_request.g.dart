// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_linkedin_email_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendLinkedInEmailRequest _$SendLinkedInEmailRequestFromJson(
  Map<String, dynamic> json,
) => _SendLinkedInEmailRequest(
  recipientEmail: json['recipient_email'] as String,
  recipientName: json['recipient_name'] as String,
  paymentIntentId: json['payment_intent_id'] as String,
);

Map<String, dynamic> _$SendLinkedInEmailRequestToJson(
  _SendLinkedInEmailRequest instance,
) => <String, dynamic>{
  'recipient_email': instance.recipientEmail,
  'recipient_name': instance.recipientName,
  'payment_intent_id': instance.paymentIntentId,
};

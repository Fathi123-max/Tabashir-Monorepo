// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_email_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendEmailModel _$SendEmailModelFromJson(Map<String, dynamic> json) =>
    _SendEmailModel(
      email: json['email'] as String,
      subject: json['subject'] as String?,
      body: json['body'] as String?,
    );

Map<String, dynamic> _$SendEmailModelToJson(_SendEmailModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'subject': instance.subject,
      'body': instance.body,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmailVerificationRequest _$EmailVerificationRequestFromJson(
  Map<String, dynamic> json,
) => _EmailVerificationRequest(
  email: json['email'] as String,
  token: json['token'] as String?,
);

Map<String, dynamic> _$EmailVerificationRequestToJson(
  _EmailVerificationRequest instance,
) => <String, dynamic>{'email': instance.email, 'token': instance.token};

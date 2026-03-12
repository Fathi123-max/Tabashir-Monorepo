// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmailVerificationResponse _$EmailVerificationResponseFromJson(
  Map<String, dynamic> json,
) => _EmailVerificationResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : EmailVerificationData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EmailVerificationResponseToJson(
  _EmailVerificationResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_EmailVerificationData _$EmailVerificationDataFromJson(
  Map<String, dynamic> json,
) => _EmailVerificationData(
  userId: json['userId'] as String?,
  email: json['email'] as String?,
  verified: json['verified'] as bool?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$EmailVerificationDataToJson(
  _EmailVerificationData instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'email': instance.email,
  'verified': instance.verified,
  'createdAt': instance.createdAt,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OnboardingResponse _$OnboardingResponseFromJson(Map<String, dynamic> json) =>
    _OnboardingResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : OnboardingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OnboardingResponseToJson(_OnboardingResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_OnboardingData _$OnboardingDataFromJson(Map<String, dynamic> json) =>
    _OnboardingData(
      id: json['id'] as String?,
      candidateId: json['candidateId'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      onboardingCompleted: json['onboardingCompleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OnboardingDataToJson(_OnboardingData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'candidateId': instance.candidateId,
      'fullName': instance.fullName,
      'email': instance.email,
      'phone': instance.phone,
      'country': instance.country,
      'city': instance.city,
      'onboardingCompleted': instance.onboardingCompleted,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

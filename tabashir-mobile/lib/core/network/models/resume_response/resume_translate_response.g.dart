// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_translate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeTranslateResponse _$ResumeTranslateResponseFromJson(
  Map<String, dynamic> json,
) => _ResumeTranslateResponse(
  success: json['success'] as bool,
  resume: ResumeItem.fromJson(json['resume'] as Map<String, dynamic>),
  targetLanguage: json['targetLanguage'] as String,
  message: json['message'] as String?,
);

Map<String, dynamic> _$ResumeTranslateResponseToJson(
  _ResumeTranslateResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'resume': instance.resume,
  'targetLanguage': instance.targetLanguage,
  'message': instance.message,
};

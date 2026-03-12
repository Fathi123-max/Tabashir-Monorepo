// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_duplicate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeDuplicateResponse _$ResumeDuplicateResponseFromJson(
  Map<String, dynamic> json,
) => _ResumeDuplicateResponse(
  success: json['success'] as bool,
  resume: ResumeItem.fromJson(json['resume'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$ResumeDuplicateResponseToJson(
  _ResumeDuplicateResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'resume': instance.resume,
  'message': instance.message,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeUploadResponse _$ResumeUploadResponseFromJson(
  Map<String, dynamic> json,
) => _ResumeUploadResponse(
  success: json['success'] as bool,
  resume: ResumeItem.fromJson(json['resume'] as Map<String, dynamic>),
  message: json['message'] as String?,
);

Map<String, dynamic> _$ResumeUploadResponseToJson(
  _ResumeUploadResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'resume': instance.resume,
  'message': instance.message,
};

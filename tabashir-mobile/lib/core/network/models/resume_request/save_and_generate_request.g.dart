// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_and_generate_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SaveAndGenerateRequest _$SaveAndGenerateRequestFromJson(
  Map<String, dynamic> json,
) => _SaveAndGenerateRequest(
  resumeData: ResumeData.fromJson(json['resume_data'] as Map<String, dynamic>),
  templateId: json['template_id'] as String?,
  filename: json['filename'] as String?,
);

Map<String, dynamic> _$SaveAndGenerateRequestToJson(
  _SaveAndGenerateRequest instance,
) => <String, dynamic>{
  'resume_data': instance.resumeData,
  'template_id': instance.templateId,
  'filename': instance.filename,
};

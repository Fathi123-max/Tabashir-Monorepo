// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ai_resume_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateAiResumeResponse _$CreateAiResumeResponseFromJson(
  Map<String, dynamic> json,
) => _CreateAiResumeResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : CreateAiResumeData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateAiResumeResponseToJson(
  _CreateAiResumeResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'data': instance.data,
};

_CreateAiResumeData _$CreateAiResumeDataFromJson(Map<String, dynamic> json) =>
    _CreateAiResumeData(
      id: json['id'] as String?,
      candidateId: json['candidateId'] as String?,
      status: json['status'] as String?,
      progress: (json['progress'] as num?)?.toInt(),
      originalUrl: json['originalUrl'] as String?,
      formatedUrl: json['formatedUrl'] as String?,
      formatedContent: json['formatedContent'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CreateAiResumeDataToJson(_CreateAiResumeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'candidateId': instance.candidateId,
      'status': instance.status,
      'progress': instance.progress,
      'originalUrl': instance.originalUrl,
      'formatedUrl': instance.formatedUrl,
      'formatedContent': instance.formatedContent,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

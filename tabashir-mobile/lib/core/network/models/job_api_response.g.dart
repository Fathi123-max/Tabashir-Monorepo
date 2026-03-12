// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobApiResponse _$JobApiResponseFromJson(Map<String, dynamic> json) =>
    _JobApiResponse(
      success: json['success'] as bool,
      job: json['job'] == null
          ? null
          : JobDetailsResponse.fromJson(json['job'] as Map<String, dynamic>),
      message: json['message'] as String?,
      language: json['language'] as String?,
    );

Map<String, dynamic> _$JobApiResponseToJson(_JobApiResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'job': instance.job,
      'message': instance.message,
      'language': instance.language,
    };

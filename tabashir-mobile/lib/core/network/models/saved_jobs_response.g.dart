// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_jobs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SavedJobsResponse _$SavedJobsResponseFromJson(Map<String, dynamic> json) =>
    _SavedJobsResponse(
      success: json['success'] as bool,
      savedJobs:
          (json['savedJobs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      count: (json['count'] as num?)?.toInt(),
      message: json['message'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$SavedJobsResponseToJson(_SavedJobsResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'savedJobs': instance.savedJobs,
      'count': instance.count,
      'message': instance.message,
      'error': instance.error,
    };

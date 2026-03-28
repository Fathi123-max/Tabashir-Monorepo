// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobsCountResponse _$JobsCountResponseFromJson(Map<String, dynamic> json) =>
    _JobsCountResponse(
      success: json['success'] as bool,
      email: json['email'] as String,
      appliedJobsCount: (json['applied_jobs_count'] as num).toInt(),
    );

Map<String, dynamic> _$JobsCountResponseToJson(_JobsCountResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'email': instance.email,
      'applied_jobs_count': instance.appliedJobsCount,
    };

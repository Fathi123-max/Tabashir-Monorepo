// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobsListResponse _$JobsListResponseFromJson(Map<String, dynamic> json) =>
    _JobsListResponse(
      success: json['success'] as bool?,
      jobs: (json['jobs'] as List<dynamic>?)
          ?.map((e) => JobDetailsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$JobsListResponseToJson(_JobsListResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'jobs': instance.jobs,
      'pagination': instance.pagination,
    };

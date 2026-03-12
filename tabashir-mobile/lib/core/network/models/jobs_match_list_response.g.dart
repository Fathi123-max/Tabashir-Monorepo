// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jobs_match_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobsMatchListResponse _$JobsMatchListResponseFromJson(
  Map<String, dynamic> json,
) => _JobsMatchListResponse(
  success: json['success'] as bool,
  matchedJobs: (json['matched_jobs'] as List<dynamic>)
      .map((e) => JobDetailsResponse.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] as Map<String, dynamic>,
);

Map<String, dynamic> _$JobsMatchListResponseToJson(
  _JobsMatchListResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'matched_jobs': instance.matchedJobs,
  'pagination': instance.pagination,
};

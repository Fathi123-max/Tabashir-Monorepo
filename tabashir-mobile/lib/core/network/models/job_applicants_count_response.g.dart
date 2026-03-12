// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_applicants_count_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobApplicantsCountResponse _$JobApplicantsCountResponseFromJson(
  Map<String, dynamic> json,
) => _JobApplicantsCountResponse(
  success: json['success'] as bool,
  jobId: (json['jobId'] as num).toInt(),
  jobTitle: json['jobTitle'] as String,
  totalApplicants: (json['total_applicants'] as num).toInt(),
  statusFilter: json['status_filter'] as String,
);

Map<String, dynamic> _$JobApplicantsCountResponseToJson(
  _JobApplicantsCountResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'jobId': instance.jobId,
  'jobTitle': instance.jobTitle,
  'total_applicants': instance.totalApplicants,
  'status_filter': instance.statusFilter,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_jobs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppliedJobsResponse _$AppliedJobsResponseFromJson(Map<String, dynamic> json) =>
    _AppliedJobsResponse(
      success: json['success'] as bool,
      email: json['email'] as String,
      jobs: (json['jobs'] as List<dynamic>)
          .map((e) => AppliedJob.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppliedJobsResponseToJson(
  _AppliedJobsResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'email': instance.email,
  'jobs': instance.jobs,
};

_AppliedJob _$AppliedJobFromJson(Map<String, dynamic> json) => _AppliedJob(
  jobTitle: json['job_title'] as String,
  jobId: json['job_id'] as String,
  status: json['status'] as String,
  location: json['location'] as String,
  applied: json['applied'] as String,
  experience: json['experience'] as String,
  company: json['company'] as String,
);

Map<String, dynamic> _$AppliedJobToJson(_AppliedJob instance) =>
    <String, dynamic>{
      'job_title': instance.jobTitle,
      'job_id': instance.jobId,
      'status': instance.status,
      'location': instance.location,
      'applied': instance.applied,
      'experience': instance.experience,
      'company': instance.company,
    };

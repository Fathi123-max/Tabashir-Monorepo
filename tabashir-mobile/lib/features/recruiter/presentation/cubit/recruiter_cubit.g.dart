// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recruiter_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecruiterState _$RecruiterStateFromJson(Map<String, dynamic> json) =>
    _RecruiterState(
      status:
          $enumDecodeNullable(_$RecruiterStatusEnumMap, json['status']) ??
          RecruiterStatus.initial,
      errorMessage: json['errorMessage'] as String? ?? '',
      profile: json['profile'] == null
          ? null
          : RecruiterProfile.fromJson(json['profile'] as Map<String, dynamic>),
      jobPostings:
          (json['jobPostings'] as List<dynamic>?)
              ?.map((e) => JobPosting.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      applications:
          (json['applications'] as List<dynamic>?)
              ?.map((e) => JobApplication.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentJobPosting: json['currentJobPosting'] == null
          ? null
          : JobPosting.fromJson(
              json['currentJobPosting'] as Map<String, dynamic>,
            ),
      jobApplications:
          (json['jobApplications'] as List<dynamic>?)
              ?.map((e) => JobApplication.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RecruiterStateToJson(_RecruiterState instance) =>
    <String, dynamic>{
      'status': _$RecruiterStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'profile': instance.profile,
      'jobPostings': instance.jobPostings,
      'applications': instance.applications,
      'currentJobPosting': instance.currentJobPosting,
      'jobApplications': instance.jobApplications,
    };

const _$RecruiterStatusEnumMap = {
  RecruiterStatus.initial: 'initial',
  RecruiterStatus.loading: 'loading',
  RecruiterStatus.loaded: 'loaded',
  RecruiterStatus.error: 'error',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_applications_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobApplicationsState _$JobApplicationsStateFromJson(
  Map<String, dynamic> json,
) => _JobApplicationsState(
  status:
      $enumDecodeNullable(_$JobApplicationsStatusEnumMap, json['status']) ??
      JobApplicationsStatus.initial,
  appliedJobs:
      (json['appliedJobs'] as List<dynamic>?)
          ?.map((e) => AppliedJob.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  totalApplications: (json['totalApplications'] as num?)?.toInt() ?? 0,
  errorMessage: json['errorMessage'] as String? ?? '',
);

Map<String, dynamic> _$JobApplicationsStateToJson(
  _JobApplicationsState instance,
) => <String, dynamic>{
  'status': _$JobApplicationsStatusEnumMap[instance.status]!,
  'appliedJobs': instance.appliedJobs,
  'totalApplications': instance.totalApplications,
  'errorMessage': instance.errorMessage,
};

const _$JobApplicationsStatusEnumMap = {
  JobApplicationsStatus.initial: 'initial',
  JobApplicationsStatus.loading: 'loading',
  JobApplicationsStatus.success: 'success',
  JobApplicationsStatus.error: 'error',
};

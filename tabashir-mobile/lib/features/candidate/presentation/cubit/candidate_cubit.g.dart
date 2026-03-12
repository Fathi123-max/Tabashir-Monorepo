// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CandidateState _$CandidateStateFromJson(Map<String, dynamic> json) =>
    _CandidateState(
      status:
          $enumDecodeNullable(_$CandidateStatusEnumMap, json['status']) ??
          CandidateStatus.initial,
      errorMessage: json['errorMessage'] as String? ?? '',
      profile: json['profile'] == null
          ? null
          : CandidateProfile.fromJson(json['profile'] as Map<String, dynamic>),
      allCandidates:
          (json['allCandidates'] as List<dynamic>?)
              ?.map((e) => CandidateProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      searchResults:
          (json['searchResults'] as List<dynamic>?)
              ?.map((e) => CandidateProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      resumes:
          (json['resumes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      jobApplications:
          (json['jobApplications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CandidateStateToJson(_CandidateState instance) =>
    <String, dynamic>{
      'status': _$CandidateStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'profile': instance.profile,
      'allCandidates': instance.allCandidates,
      'searchResults': instance.searchResults,
      'resumes': instance.resumes,
      'jobApplications': instance.jobApplications,
    };

const _$CandidateStatusEnumMap = {
  CandidateStatus.initial: 'initial',
  CandidateStatus.loading: 'loading',
  CandidateStatus.loaded: 'loaded',
  CandidateStatus.error: 'error',
};

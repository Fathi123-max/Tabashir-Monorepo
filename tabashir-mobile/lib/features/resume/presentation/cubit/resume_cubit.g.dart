// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeState _$ResumeStateFromJson(Map<String, dynamic> json) => _ResumeState(
  status:
      $enumDecodeNullable(_$ResumeCubitStatusEnumMap, json['status']) ??
      ResumeCubitStatus.initial,
  errorMessage: json['errorMessage'] as String? ?? '',
  resumes:
      (json['resumes'] as List<dynamic>?)
          ?.map((e) => Resume.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currentResume: json['currentResume'] == null
      ? null
      : Resume.fromJson(json['currentResume'] as Map<String, dynamic>),
  exportUrl: json['exportUrl'] as String?,
);

Map<String, dynamic> _$ResumeStateToJson(_ResumeState instance) =>
    <String, dynamic>{
      'status': _$ResumeCubitStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'resumes': instance.resumes,
      'currentResume': instance.currentResume,
      'exportUrl': instance.exportUrl,
    };

const _$ResumeCubitStatusEnumMap = {
  ResumeCubitStatus.initial: 'initial',
  ResumeCubitStatus.loading: 'loading',
  ResumeCubitStatus.loaded: 'loaded',
  ResumeCubitStatus.error: 'error',
};

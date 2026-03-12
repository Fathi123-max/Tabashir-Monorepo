// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_resume_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiResumeState _$AiResumeStateFromJson(Map<String, dynamic> json) =>
    _AiResumeState(
      status:
          $enumDecodeNullable(_$AiResumeStatusEnumMap, json['status']) ??
          AiResumeStatus.initial,
      errorMessage: json['errorMessage'] as String? ?? '',
      resume: json['resume'] == null
          ? null
          : CreateAiResumeResponse.fromJson(
              json['resume'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AiResumeStateToJson(_AiResumeState instance) =>
    <String, dynamic>{
      'status': _$AiResumeStatusEnumMap[instance.status]!,
      'errorMessage': instance.errorMessage,
      'resume': instance.resume,
    };

const _$AiResumeStatusEnumMap = {
  AiResumeStatus.initial: 'initial',
  AiResumeStatus.loading: 'loading',
  AiResumeStatus.success: 'success',
  AiResumeStatus.error: 'error',
};

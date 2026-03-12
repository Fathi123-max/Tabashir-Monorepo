// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ai_resume_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateAiResumeRequest _$CreateAiResumeRequestFromJson(
  Map<String, dynamic> json,
) => _CreateAiResumeRequest(
  personalDetailsJson: json['personalDetailsJson'] as String,
  professionalDetailsJson: json['professionalDetailsJson'] as String,
  employmentHistoryJson: json['employmentHistoryJson'] as String,
  educationJson: json['educationJson'] as String,
  skillsJson: json['skillsJson'] as String,
  languagesJson: json['languagesJson'] as String,
);

Map<String, dynamic> _$CreateAiResumeRequestToJson(
  _CreateAiResumeRequest instance,
) => <String, dynamic>{
  'personalDetailsJson': instance.personalDetailsJson,
  'professionalDetailsJson': instance.professionalDetailsJson,
  'employmentHistoryJson': instance.employmentHistoryJson,
  'educationJson': instance.educationJson,
  'skillsJson': instance.skillsJson,
  'languagesJson': instance.languagesJson,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeListResponse _$ResumeListResponseFromJson(Map<String, dynamic> json) =>
    _ResumeListResponse(
      success: json['success'] as bool,
      resumes: (json['resumes'] as List<dynamic>)
          .map((e) => ResumeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResumeListResponseToJson(_ResumeListResponse instance) =>
    <String, dynamic>{'success': instance.success, 'resumes': instance.resumes};

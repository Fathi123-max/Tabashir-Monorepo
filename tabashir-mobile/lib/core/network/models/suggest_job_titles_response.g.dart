// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggest_job_titles_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SuggestJobTitlesResponse _$SuggestJobTitlesResponseFromJson(
  Map<String, dynamic> json,
) => _SuggestJobTitlesResponse(
  success: json['success'] as bool,
  suggestedJobTitles: (json['suggested_job_titles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SuggestJobTitlesResponseToJson(
  _SuggestJobTitlesResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'suggested_job_titles': instance.suggestedJobTitles,
};

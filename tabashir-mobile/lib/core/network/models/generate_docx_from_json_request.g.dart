// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_docx_from_json_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GenerateDocxFromJsonRequest _$GenerateDocxFromJsonRequestFromJson(
  Map<String, dynamic> json,
) => _GenerateDocxFromJsonRequest(
  formattedResume: json['formatted_resume'] as Map<String, dynamic>,
  outputLanguage: json['outputLanguage'] as String? ?? 'regular',
);

Map<String, dynamic> _$GenerateDocxFromJsonRequestToJson(
  _GenerateDocxFromJsonRequest instance,
) => <String, dynamic>{
  'formatted_resume': instance.formattedResume,
  'outputLanguage': instance.outputLanguage,
};

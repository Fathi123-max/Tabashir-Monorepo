// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_format_from_raw_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CVFormatFromRawRequest _$CVFormatFromRawRequestFromJson(
  Map<String, dynamic> json,
) => _CVFormatFromRawRequest(
  rawData: json['raw_data'] as String,
  outputLanguage: json['outputLanguage'] as String? ?? 'regular',
);

Map<String, dynamic> _$CVFormatFromRawRequestToJson(
  _CVFormatFromRawRequest instance,
) => <String, dynamic>{
  'raw_data': instance.rawData,
  'outputLanguage': instance.outputLanguage,
};

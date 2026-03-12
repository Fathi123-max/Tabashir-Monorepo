// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_cv_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RawCVInput _$RawCVInputFromJson(Map<String, dynamic> json) => _RawCVInput(
  userId: json['user_id'] as String,
  rawData: json['raw_data'] as String,
  outputLanguage: json['outputLanguage'] as String? ?? 'regular',
);

Map<String, dynamic> _$RawCVInputToJson(_RawCVInput instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'raw_data': instance.rawData,
      'outputLanguage': instance.outputLanguage,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_format_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CVFormatResponse _$CVFormatResponseFromJson(Map<String, dynamic> json) =>
    _CVFormatResponse(
      success: json['success'] as bool,
      formattedCv: json['formattedCv'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CVFormatResponseToJson(_CVFormatResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'formattedCv': instance.formattedCv,
      'message': instance.message,
    };

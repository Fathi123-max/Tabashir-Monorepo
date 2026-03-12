// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiResponse<T> _$ApiResponseFromJson<T>(Map<String, dynamic> json) =>
    _ApiResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ApiResponseToJson<T>(_ApiResponse<T> instance) =>
    <String, dynamic>{'success': instance.success, 'message': instance.message};

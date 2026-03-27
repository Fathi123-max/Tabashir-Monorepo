// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_client_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiClientResponse _$AiClientResponseFromJson(Map<String, dynamic> json) =>
    _AiClientResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AiClientData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AiClientResponseToJson(_AiClientResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_AiClientData _$AiClientDataFromJson(Map<String, dynamic> json) =>
    _AiClientData(
      nationality: json['nationality'] as String?,
      gender: json['gender'] as String?,
      location: json['location'] as String?,
      positions: json['positions'] as String?,
      filename: json['filename'] as String?,
    );

Map<String, dynamic> _$AiClientDataToJson(_AiClientData instance) =>
    <String, dynamic>{
      'nationality': instance.nationality,
      'gender': instance.gender,
      'location': instance.location,
      'positions': instance.positions,
      'filename': instance.filename,
    };

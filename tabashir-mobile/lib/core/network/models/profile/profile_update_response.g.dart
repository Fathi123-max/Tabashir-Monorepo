// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileUpdateResponse _$ProfileUpdateResponseFromJson(
  Map<String, dynamic> json,
) => _ProfileUpdateResponse(
  success: json['success'] as bool,
  message: json['message'] as String,
);

Map<String, dynamic> _$ProfileUpdateResponseToJson(
  _ProfileUpdateResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_delete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeDeleteResponse _$ResumeDeleteResponseFromJson(
  Map<String, dynamic> json,
) => _ResumeDeleteResponse(
  success: json['success'] as bool,
  message: json['message'] as String?,
);

Map<String, dynamic> _$ResumeDeleteResponseToJson(
  _ResumeDeleteResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
};

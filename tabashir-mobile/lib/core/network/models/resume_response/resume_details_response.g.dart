// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeDetailsResponse _$ResumeDetailsResponseFromJson(
  Map<String, dynamic> json,
) => _ResumeDetailsResponse(
  success: json['success'] as bool,
  resume: ResumeItem.fromJson(json['resume'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ResumeDetailsResponseToJson(
  _ResumeDetailsResponse instance,
) => <String, dynamic>{'success': instance.success, 'resume': instance.resume};

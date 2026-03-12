// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_job_apply_config_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiJobApplyConfigResponse _$AiJobApplyConfigResponseFromJson(
  Map<String, dynamic> json,
) => _AiJobApplyConfigResponse(
  popularRoles: (json['popularRoles'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  popularLocations: (json['popularLocations'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  nationalities: (json['nationalities'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  maxRolesToShow: (json['maxRolesToShow'] as num).toInt(),
  maxLocationsToShow: (json['maxLocationsToShow'] as num).toInt(),
  defaultAiConfidence: (json['defaultAiConfidence'] as num).toInt(),
  version: json['version'] as String,
  expiresAt: json['expiresAt'] as String,
);

Map<String, dynamic> _$AiJobApplyConfigResponseToJson(
  _AiJobApplyConfigResponse instance,
) => <String, dynamic>{
  'popularRoles': instance.popularRoles,
  'popularLocations': instance.popularLocations,
  'nationalities': instance.nationalities,
  'maxRolesToShow': instance.maxRolesToShow,
  'maxLocationsToShow': instance.maxLocationsToShow,
  'defaultAiConfidence': instance.defaultAiConfidence,
  'version': instance.version,
  'expiresAt': instance.expiresAt,
};

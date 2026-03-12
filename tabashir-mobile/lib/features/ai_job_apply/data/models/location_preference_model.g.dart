// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_preference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationPreferenceModel _$LocationPreferenceModelFromJson(
  Map<String, dynamic> json,
) => _LocationPreferenceModel(
  id: json['id'] as String,
  name: json['name'] as String,
  isCustom: json['isCustom'] as bool? ?? false,
  type: json['type'] as String? ?? 'unspecified',
  matchScore: (json['matchScore'] as num?)?.toInt() ?? -1,
  growthPercentage: (json['growthPercentage'] as num?)?.toInt() ?? 0,
  description: json['description'] as String? ?? 'No description available',
);

Map<String, dynamic> _$LocationPreferenceModelToJson(
  _LocationPreferenceModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'isCustom': instance.isCustom,
  'type': instance.type,
  'matchScore': instance.matchScore,
  'growthPercentage': instance.growthPercentage,
  'description': instance.description,
};

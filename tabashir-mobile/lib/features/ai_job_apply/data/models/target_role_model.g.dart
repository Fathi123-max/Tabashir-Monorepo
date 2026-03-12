// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_role_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TargetRoleModel _$TargetRoleModelFromJson(Map<String, dynamic> json) =>
    _TargetRoleModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCustom: json['isCustom'] as bool? ?? false,
      description: json['description'] as String? ?? 'No description available',
      matchScore: (json['matchScore'] as num?)?.toInt() ?? -1,
      potentialRoles: (json['potentialRoles'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TargetRoleModelToJson(_TargetRoleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isCustom': instance.isCustom,
      'description': instance.description,
      'matchScore': instance.matchScore,
      'potentialRoles': instance.potentialRoles,
    };

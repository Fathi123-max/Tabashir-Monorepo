// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_selection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeSelectionModel _$ResumeSelectionModelFromJson(
  Map<String, dynamic> json,
) => _ResumeSelectionModel(
  id: json['id'] as String,
  title: json['title'] as String,
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
  matchPercentage: (json['matchPercentage'] as num?)?.toInt() ?? -1,
  isRecommended: json['isRecommended'] as bool? ?? false,
  description: json['description'] as String? ?? 'No description available',
);

Map<String, dynamic> _$ResumeSelectionModelToJson(
  _ResumeSelectionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
  'matchPercentage': instance.matchPercentage,
  'isRecommended': instance.isRecommended,
  'description': instance.description,
};

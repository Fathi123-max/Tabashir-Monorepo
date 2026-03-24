// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeItem _$ResumeItemFromJson(Map<String, dynamic> json) => _ResumeItem(
  id: json['id'] as String,
  filename: json['filename'] as String,
  originalUrl: json['originalUrl'] as String?,
  formatedUrl: json['formatedUrl'] as String?,
  isAiResume: json['isAiResume'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  formatedContent: json['formatedContent'] as String?,
  sourceData: json['sourceData'] == null
      ? null
      : ResumeData.fromJson(json['sourceData'] as Map<String, dynamic>),
  name: json['name'] as String? ?? '',
  filePath: json['filePath'] as String? ?? '',
  fileType: json['fileType'] as String? ?? '',
  fileSize: (json['fileSize'] as num?)?.toInt() ?? 0,
  lastModified: json['lastModified'] as String? ?? '',
  isDefault: json['isDefault'] as bool? ?? false,
  title: json['title'] as String? ?? '',
);

Map<String, dynamic> _$ResumeItemToJson(_ResumeItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filename': instance.filename,
      'originalUrl': instance.originalUrl,
      'formatedUrl': instance.formatedUrl,
      'isAiResume': instance.isAiResume,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'formatedContent': instance.formatedContent,
      'sourceData': instance.sourceData,
      'name': instance.name,
      'filePath': instance.filePath,
      'fileType': instance.fileType,
      'fileSize': instance.fileSize,
      'lastModified': instance.lastModified,
      'isDefault': instance.isDefault,
      'title': instance.title,
    };

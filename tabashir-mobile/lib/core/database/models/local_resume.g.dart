// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_resume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocalResume _$LocalResumeFromJson(Map<String, dynamic> json) => _LocalResume(
  id: json['id'] as String,
  name: json['name'] as String,
  title: json['title'] as String,
  filePath: json['filePath'] as String,
  fileType: json['fileType'] as String,
  fileSize: (json['fileSize'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  isDefault: json['isDefault'] as bool? ?? false,
);

Map<String, dynamic> _$LocalResumeToJson(_LocalResume instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'title': instance.title,
      'filePath': instance.filePath,
      'fileType': instance.fileType,
      'fileSize': instance.fileSize,
      'createdAt': instance.createdAt.toIso8601String(),
      'isDefault': instance.isDefault,
    };

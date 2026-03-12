// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_export_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeExportResponse _$ResumeExportResponseFromJson(
  Map<String, dynamic> json,
) => _ResumeExportResponse(
  success: json['success'] as bool,
  exportUrl: json['exportUrl'] as String,
  filename: json['filename'] as String,
  isFormatted: json['isFormatted'] as bool,
  message: json['message'] as String?,
);

Map<String, dynamic> _$ResumeExportResponseToJson(
  _ResumeExportResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'exportUrl': instance.exportUrl,
  'filename': instance.filename,
  'isFormatted': instance.isFormatted,
  'message': instance.message,
};

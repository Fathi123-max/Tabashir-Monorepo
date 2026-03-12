// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadState _$UploadStateFromJson(Map<String, dynamic> json) => _UploadState(
  status:
      $enumDecodeNullable(_$UploadStatusEnumMap, json['status']) ??
      UploadStatus.initial,
  progress: (json['progress'] as num?)?.toInt() ?? 0,
  errorMessage: json['errorMessage'] as String? ?? '',
  uploadResponse: json['uploadResponse'] == null
      ? null
      : UploadResponse.fromJson(json['uploadResponse'] as Map<String, dynamic>),
  uploadedFiles:
      (json['uploadedFiles'] as List<dynamic>?)
          ?.map((e) => UploadResponse.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$UploadStateToJson(_UploadState instance) =>
    <String, dynamic>{
      'status': _$UploadStatusEnumMap[instance.status]!,
      'progress': instance.progress,
      'errorMessage': instance.errorMessage,
      'uploadResponse': instance.uploadResponse,
      'uploadedFiles': instance.uploadedFiles,
    };

const _$UploadStatusEnumMap = {
  UploadStatus.initial: 'initial',
  UploadStatus.loading: 'loading',
  UploadStatus.success: 'success',
  UploadStatus.error: 'error',
};

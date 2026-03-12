// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) =>
    _UploadResponse(
      success: json['success'] as bool,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UploadData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UploadResponseToJson(_UploadResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_UploadData _$UploadDataFromJson(Map<String, dynamic> json) => _UploadData(
  fileUrl: json['fileUrl'] as String?,
  fileId: json['fileId'] as String?,
  fileName: json['fileName'] as String?,
  fileType: json['fileType'] as String?,
  fileSize: (json['fileSize'] as num?)?.toInt(),
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$UploadDataToJson(_UploadData instance) =>
    <String, dynamic>{
      'fileUrl': instance.fileUrl,
      'fileId': instance.fileId,
      'fileName': instance.fileName,
      'fileType': instance.fileType,
      'fileSize': instance.fileSize,
      'createdAt': instance.createdAt,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadRequest _$UploadRequestFromJson(Map<String, dynamic> json) =>
    _UploadRequest(
      fileName: json['fileName'] as String,
      fileType: json['fileType'] as String,
    );

Map<String, dynamic> _$UploadRequestToJson(_UploadRequest instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'fileType': instance.fileType,
    };

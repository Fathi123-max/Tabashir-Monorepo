import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_response.freezed.dart';
part 'upload_response.g.dart';

/// File upload response model
@freezed
sealed class UploadResponse with _$UploadResponse {
  const factory UploadResponse({
    required bool success,
    String? message,
    UploadData? data,
  }) = _UploadResponse;

  factory UploadResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadResponseFromJson(json);
}

/// Upload data
@freezed
sealed class UploadData with _$UploadData {
  const factory UploadData({
    String? fileUrl,
    String? fileId,
    String? fileName,
    String? fileType,
    int? fileSize,
    String? createdAt,
  }) = _UploadData;

  factory UploadData.fromJson(Map<String, dynamic> json) =>
      _$UploadDataFromJson(json);
}

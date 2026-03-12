import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_request.freezed.dart';
part 'upload_request.g.dart';

/// File upload request model
@freezed
sealed class UploadRequest with _$UploadRequest {
  const factory UploadRequest({
    required String fileName,
    required String fileType,
  }) = _UploadRequest;

  factory UploadRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadRequestFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';

part 'resume_upload_response.freezed.dart';
part 'resume_upload_response.g.dart';

@freezed
sealed class ResumeUploadResponse with _$ResumeUploadResponse {
  const factory ResumeUploadResponse({
    required bool success,
    required ResumeItem resume,
    String? message,
  }) = _ResumeUploadResponse;

  factory ResumeUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$ResumeUploadResponseFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_export_response.freezed.dart';
part 'resume_export_response.g.dart';

@freezed
sealed class ResumeExportResponse with _$ResumeExportResponse {
  const factory ResumeExportResponse({
    required bool success,
    required String exportUrl,
    required String filename,
    required bool isFormatted,
    String? message,
  }) = _ResumeExportResponse;

  factory ResumeExportResponse.fromJson(Map<String, dynamic> json) =>
      _$ResumeExportResponseFromJson(json);
}

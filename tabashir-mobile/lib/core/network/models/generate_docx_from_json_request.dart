import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate_docx_from_json_request.freezed.dart';
part 'generate_docx_from_json_request.g.dart';

/// Request model for generating DOCX from structured JSON
@freezed
sealed class GenerateDocxFromJsonRequest with _$GenerateDocxFromJsonRequest {
  const factory GenerateDocxFromJsonRequest({
    /// Structured resume data in JSON format
    @JsonKey(name: 'formatted_resume')
    required Map<String, dynamic> formattedResume,

    /// Output language: 'regular' or 'arabic'
    @Default('regular') String? outputLanguage,
  }) = _GenerateDocxFromJsonRequest;

  factory GenerateDocxFromJsonRequest.fromJson(Map<String, dynamic> json) =>
      _$GenerateDocxFromJsonRequestFromJson(json);
}

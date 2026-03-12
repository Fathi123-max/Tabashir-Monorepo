import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_ai_resume_request.freezed.dart';
part 'create_ai_resume_request.g.dart';

/// Create AI resume request model
@freezed
sealed class CreateAiResumeRequest with _$CreateAiResumeRequest {
  const factory CreateAiResumeRequest({
    required String personalDetailsJson,
    required String professionalDetailsJson,
    required String employmentHistoryJson,
    required String educationJson,
    required String skillsJson,
    required String languagesJson,
  }) = _CreateAiResumeRequest;

  factory CreateAiResumeRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateAiResumeRequestFromJson(json);
}

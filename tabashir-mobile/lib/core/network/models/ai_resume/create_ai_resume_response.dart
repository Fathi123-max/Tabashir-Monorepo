import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_ai_resume_response.freezed.dart';
part 'create_ai_resume_response.g.dart';

/// Create AI resume response model
@freezed
sealed class CreateAiResumeResponse with _$CreateAiResumeResponse {
  const factory CreateAiResumeResponse({
    required bool success,
    String? message,
    CreateAiResumeData? data,
  }) = _CreateAiResumeResponse;

  factory CreateAiResumeResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAiResumeResponseFromJson(json);
}

/// Create AI resume data
@freezed
sealed class CreateAiResumeData with _$CreateAiResumeData {
  const factory CreateAiResumeData({
    String? id,
    String? candidateId,
    String? status,
    int? progress,
    String? originalUrl,
    String? formatedUrl,
    String? formatedContent,
    String? createdAt,
    String? updatedAt,
  }) = _CreateAiResumeData;

  factory CreateAiResumeData.fromJson(Map<String, dynamic> json) =>
      _$CreateAiResumeDataFromJson(json);
}

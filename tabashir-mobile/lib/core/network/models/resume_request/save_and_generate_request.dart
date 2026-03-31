import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/ai_resume/resume_models.dart';

part 'save_and_generate_request.freezed.dart';
part 'save_and_generate_request.g.dart';

@freezed
sealed class SaveAndGenerateRequest with _$SaveAndGenerateRequest {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SaveAndGenerateRequest({
    required ResumeData resumeData,
    String? templateId,
    String? filename,
    String? paymentIntentId,
  }) = _SaveAndGenerateRequest;

  factory SaveAndGenerateRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveAndGenerateRequestFromJson(json);

  Map<String, dynamic> toJson();
}

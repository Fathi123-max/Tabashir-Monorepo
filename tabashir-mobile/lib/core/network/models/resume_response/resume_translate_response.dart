import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';

part 'resume_translate_response.freezed.dart';
part 'resume_translate_response.g.dart';

@freezed
sealed class ResumeTranslateResponse with _$ResumeTranslateResponse {
  const factory ResumeTranslateResponse({
    required bool success,
    required ResumeItem resume,
    required String targetLanguage,
    String? message,
  }) = _ResumeTranslateResponse;

  factory ResumeTranslateResponse.fromJson(Map<String, dynamic> json) =>
      _$ResumeTranslateResponseFromJson(json);
}

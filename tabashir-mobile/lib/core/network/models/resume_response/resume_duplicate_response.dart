import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';

part 'resume_duplicate_response.freezed.dart';
part 'resume_duplicate_response.g.dart';

@freezed
sealed class ResumeDuplicateResponse with _$ResumeDuplicateResponse {
  const factory ResumeDuplicateResponse({
    required bool success,
    required ResumeItem resume,
    String? message,
  }) = _ResumeDuplicateResponse;

  factory ResumeDuplicateResponse.fromJson(Map<String, dynamic> json) =>
      _$ResumeDuplicateResponseFromJson(json);
}

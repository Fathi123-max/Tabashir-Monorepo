import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_delete_response.freezed.dart';
part 'resume_delete_response.g.dart';

@freezed
sealed class ResumeDeleteResponse with _$ResumeDeleteResponse {
  const factory ResumeDeleteResponse({
    required bool success,
    String? message,
  }) = _ResumeDeleteResponse;

  factory ResumeDeleteResponse.fromJson(Map<String, dynamic> json) =>
      _$ResumeDeleteResponseFromJson(json);
}

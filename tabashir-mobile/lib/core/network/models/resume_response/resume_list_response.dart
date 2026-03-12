import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';

part 'resume_list_response.freezed.dart';
part 'resume_list_response.g.dart';

@freezed
sealed class ResumeListResponse with _$ResumeListResponse {
  const factory ResumeListResponse({
    required bool success,
    required List<ResumeItem> resumes,
  }) = _ResumeListResponse;

  factory ResumeListResponse.fromJson(Map<String, dynamic> json) =>
      _$ResumeListResponseFromJson(json);
}

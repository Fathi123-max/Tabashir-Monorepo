import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_applicants_count_response.freezed.dart';
part 'job_applicants_count_response.g.dart';

/// Response model for job applicants count
@freezed
sealed class JobApplicantsCountResponse with _$JobApplicantsCountResponse {
  const factory JobApplicantsCountResponse({
    /// Success status
    required bool success,

    /// Job ID
    required int jobId,

    /// Job title
    required String jobTitle,

    /// Total number of applicants
    @JsonKey(name: 'total_applicants') required int totalApplicants,

    /// Status filter applied
    @JsonKey(name: 'status_filter') required String statusFilter,
  }) = _JobApplicantsCountResponse;

  factory JobApplicantsCountResponse.fromJson(Map<String, dynamic> json) =>
      _$JobApplicantsCountResponseFromJson(json);
}

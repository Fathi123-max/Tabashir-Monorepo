import 'package:freezed_annotation/freezed_annotation.dart';

part 'applied_jobs_response.freezed.dart';
part 'applied_jobs_response.g.dart';

/// Response model for applied jobs
@freezed
sealed class AppliedJobsResponse with _$AppliedJobsResponse {
  const factory AppliedJobsResponse({
    /// Success status
    required bool success,

    /// Applicant email
    required String email,

    /// List of applied jobs
    required List<AppliedJob> jobs,
  }) = _AppliedJobsResponse;

  factory AppliedJobsResponse.fromJson(Map<String, dynamic> json) =>
      _$AppliedJobsResponseFromJson(json);
}

/// Model for a single applied job
@freezed
sealed class AppliedJob with _$AppliedJob {
  const factory AppliedJob({
    /// Job title
    @JsonKey(name: 'job_title') required String jobTitle,

    /// Job ID
    @JsonKey(name: 'job_id') required String jobId,

    /// Application status
    required String status,

    /// Job location
    required String location,

    /// Application date
    @JsonKey(name: 'applied') required String applied,

    /// Experience level
    required String experience,

    /// Company name
    required String company,
  }) = _AppliedJob;

  factory AppliedJob.fromJson(Map<String, dynamic> json) =>
      _$AppliedJobFromJson(json);
}

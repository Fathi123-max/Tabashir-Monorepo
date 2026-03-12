import 'package:freezed_annotation/freezed_annotation.dart';

part 'jobs_count_response.freezed.dart';
part 'jobs_count_response.g.dart';

/// Response model for jobs count
@freezed
sealed class JobsCountResponse with _$JobsCountResponse {
  const factory JobsCountResponse({
    /// Success status
    required bool success,

    /// Applicant email
    required String email,

    /// Count of applied jobs
    required int appliedJobsCount,
  }) = _JobsCountResponse;

  factory JobsCountResponse.fromJson(Map<String, dynamic> json) =>
      _$JobsCountResponseFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'job_details_response.dart';

part 'jobs_match_list_response.freezed.dart';
part 'jobs_match_list_response.g.dart';

/// Response model for jobs match endpoint
@freezed
sealed class JobsMatchListResponse with _$JobsMatchListResponse {
  const factory JobsMatchListResponse({
    /// Success status
    required bool success,

    /// Matched jobs (note: field name from API)
    @JsonKey(name: 'matched_jobs')
    required List<JobDetailsResponse> matchedJobs,

    /// Pagination info
    required Map<String, dynamic> pagination,
  }) = _JobsMatchListResponse;

  factory JobsMatchListResponse.fromJson(Map<String, dynamic> json) =>
      _$JobsMatchListResponseFromJson(json);
}

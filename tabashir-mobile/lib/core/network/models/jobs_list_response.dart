import 'package:freezed_annotation/freezed_annotation.dart';
import 'job_details_response.dart';

part 'jobs_list_response.freezed.dart';
part 'jobs_list_response.g.dart';

/// Response model for jobs list endpoint
@freezed
sealed class JobsListResponse with _$JobsListResponse {
  const factory JobsListResponse({
    /// Success status
    bool? success,

    /// List of jobs
    List<JobDetailsResponse>? jobs,

    /// Pagination info
    Map<String, dynamic>? pagination,
  }) = _JobsListResponse;

  factory JobsListResponse.fromJson(Map<String, dynamic> json) =>
      _$JobsListResponseFromJson(json);
}

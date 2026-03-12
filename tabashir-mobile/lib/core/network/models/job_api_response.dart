import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';

part 'job_api_response.freezed.dart';
part 'job_api_response.g.dart';

/// Wrapper for job-related API responses that include a success flag and data
@freezed
sealed class JobApiResponse with _$JobApiResponse {
  const factory JobApiResponse({
    /// Whether the API request was successful
    required bool success,

    /// The job data (only present when success is true)
    JobDetailsResponse? job,

    /// Error message (only present when success is false)
    String? message,

    /// Language of the job data
    String? language,
  }) = _JobApiResponse;

  factory JobApiResponse.fromJson(Map<String, dynamic> json) =>
      _$JobApiResponseFromJson(json);
}

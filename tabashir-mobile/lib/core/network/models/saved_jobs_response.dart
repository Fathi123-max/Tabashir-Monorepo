import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_jobs_response.freezed.dart';
part 'saved_jobs_response.g.dart';

/// Response model for saved jobs operations
@freezed
sealed class SavedJobsResponse with _$SavedJobsResponse {
  const factory SavedJobsResponse({
    /// Success status
    @Default(false) bool success,

    /// List of saved job IDs or objects (from GET operations)
    @Default([]) List<dynamic> savedJobs,

    /// Count of saved jobs
    int? count,

    /// Success message
    String? message,

    /// Error message
    String? error,
  }) = _SavedJobsResponse;

  factory SavedJobsResponse.fromJson(Map<String, dynamic> json) =>
      _$SavedJobsResponseFromJson(json);
}

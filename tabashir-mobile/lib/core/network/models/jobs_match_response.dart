import 'package:freezed_annotation/freezed_annotation.dart';

part 'jobs_match_response.freezed.dart';
part 'jobs_match_response.g.dart';

/// Response model for job matching
@freezed
sealed class JobsMatchResponse with _$JobsMatchResponse {
  const factory JobsMatchResponse({
    /// List of matched jobs
    List<MatchedJob>? matchedJobs,

    /// Total count
    int? total,
  }) = _JobsMatchResponse;

  factory JobsMatchResponse.fromJson(Map<String, dynamic> json) =>
      _$JobsMatchResponseFromJson(json);
}

/// Model for a matched job
@freezed
sealed class MatchedJob with _$MatchedJob {
  const factory MatchedJob({
    /// Job ID
    String? jobId,

    /// Job title
    String? jobTitle,

    /// Company name
    String? companyName,

    /// Match score
    double? matchScore,

    /// Match percentage
    String? matchPercentage,
  }) = _MatchedJob;

  factory MatchedJob.fromJson(Map<String, dynamic> json) =>
      _$MatchedJobFromJson(json);
}

/// Response model for POST /apply endpoint
/// Matches the actual API response structure
@freezed
sealed class ApplyJobsResponse with _$ApplyJobsResponse {
  const factory ApplyJobsResponse({
    /// Response message
    required String message,

    /// Success status
    required bool success,

    /// Summary containing apply and ranking results
    required ApplySummary summary,
  }) = _ApplyJobsResponse;

  factory ApplyJobsResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplyJobsResponseFromJson(json);
}

/// Summary of application and ranking results
@freezed
sealed class ApplySummary with _$ApplySummary {
  const factory ApplySummary({
    /// Apply result
    @JsonKey(name: 'apply_result') required ApplyResult applyResult,

    /// Client email
    required String email,

    /// Ranking result
    @JsonKey(name: 'ranking_result') required RankingResult rankingResult,
  }) = _ApplySummary;

  factory ApplySummary.fromJson(Map<String, dynamic> json) =>
      _$ApplySummaryFromJson(json);
}

/// Result of job application
@freezed
sealed class ApplyResult with _$ApplyResult {
  const factory ApplyResult({
    /// Application date
    required String date,

    /// Applicant email
    required String email,

    /// Number of matches processed
    @JsonKey(name: 'matches_processed') required int matchesProcessed,
  }) = _ApplyResult;

  factory ApplyResult.fromJson(Map<String, dynamic> json) =>
      _$ApplyResultFromJson(json);
}

/// Result of ranking/matching process
@freezed
sealed class RankingResult with _$RankingResult {
  const factory RankingResult({
    /// Number of blocked pairs
    @JsonKey(name: 'blocked_pairs_count') required int blockedPairsCount,

    /// Client email
    @JsonKey(name: 'client_email') required String clientEmail,

    /// Number of clients processed
    @JsonKey(name: 'clients_processed') required int clientsProcessed,

    /// Execution time in seconds
    @JsonKey(name: 'execution_time_seconds')
    required double executionTimeSeconds,

    /// Number of existing matches skipped
    @JsonKey(name: 'existing_matches_skipped')
    required int existingMatchesSkipped,

    /// Number of jobs processed
    @JsonKey(name: 'jobs_processed') required int jobsProcessed,

    /// Number of matches found
    @JsonKey(name: 'matches_found') required int matchesFound,

    /// Number of matches inserted
    @JsonKey(name: 'matches_inserted') required int matchesInserted,

    /// Processing date
    @JsonKey(name: 'processing_date') required String processingDate,
  }) = _RankingResult;

  factory RankingResult.fromJson(Map<String, dynamic> json) =>
      _$RankingResultFromJson(json);
}

/// Response model for POST /{job_id}/apply endpoint
/// Matches the actual API response structure
@freezed
sealed class ApplyToJobResponse with _$ApplyToJobResponse {
  const factory ApplyToJobResponse({
    /// Applied job ID
    required int appliedJobId,

    /// Applicant email
    required String email,

    /// Response message
    required String message,

    /// Success status
    required bool success,

    /// User application details
    required ApplyToJobUser user,
  }) = _ApplyToJobResponse;

  factory ApplyToJobResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplyToJobResponseFromJson(json);
}

/// User application details
@freezed
sealed class ApplyToJobUser with _$ApplyToJobUser {
  const factory ApplyToJobUser({
    /// Application date
    required String date,

    /// Applicant email
    required String email,

    /// Job applied to
    required int jobApplied,

    /// Ranking ID
    required int rankingId,
  }) = _ApplyToJobUser;

  factory ApplyToJobUser.fromJson(Map<String, dynamic> json) =>
      _$ApplyToJobUserFromJson(json);
}

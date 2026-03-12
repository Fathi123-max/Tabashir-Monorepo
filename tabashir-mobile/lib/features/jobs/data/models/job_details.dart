import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_details.freezed.dart';
part 'job_details.g.dart';

/// Represents detailed information about a job listing
@freezed
sealed class JobDetails with _$JobDetails {
  /// Creates a new instance of [JobDetails]
  const factory JobDetails({
    /// Unique identifier for the job
    required String id,

    /// Title of the job position
    required String title,

    /// Description of the job role and responsibilities
    required String description,

    /// Name of the company offering the position
    required String company,

    /// Industry sector of the company
    required String industry,

    /// Location of the job
    required String location,

    /// Salary range for the position
    required String salary,

    /// Match percentage based on user profile
    required String matchPercentage,

    /// Size of the company
    required int companySize,

    /// Year the company was founded
    required int foundedYear,

    /// Whether the company is verified
    required bool isVerified,

    /// Tags associated with the job
    required List<String> tags,

    /// List of responsibilities in this role
    required List<String> responsibilities,

    /// List of requirements for the position
    required List<String> requirements,

    /// Skills required for the position
    required List<String> skills,

    /// List of similar job opportunities
    required List<SimilarJob> similarOpportunities,

    /// Overview of the company
    String? overview,

    /// Benefits offered with the position
    String? benefits,

    /// Type of employment (full-time, part-time, etc.)
    String? employmentType,

    /// Required experience level
    String? experienceLevel,

    /// Date when the job was posted
    String? postedDate,
  }) = _JobDetails;

  /// Creates a [JobDetails] instance from JSON
  factory JobDetails.fromJson(Map<String, dynamic> json) =>
      _$JobDetailsFromJson(json);
}

/// Represents a similar job opportunity
@freezed
sealed class SimilarJob with _$SimilarJob {
  /// Creates a new instance of [SimilarJob]
  const factory SimilarJob({
    /// Unique identifier for the similar job
    required String id,

    /// Title of the similar job position
    required String title,

    /// Name of the company for the similar job
    required String company,

    /// Match percentage based on user profile
    required String matchPercentage,

    /// Tags associated with the similar job
    required List<String> tags,
  }) = _SimilarJob;

  /// Creates a [SimilarJob] instance from JSON
  factory SimilarJob.fromJson(Map<String, dynamic> json) =>
      _$SimilarJobFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_details.freezed.dart';
part 'job_details.g.dart';

/// Represents detailed information about a job listing
/// Maps directly to backend API response - NO mock data
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

    /// Location of the job
    required String location,

    /// Salary range for the position
    required String salary,

    /// Match percentage based on user profile
    required String matchPercentage,

    /// Tags associated with the job (job_type, working_hours, etc.)
    required List<String> tags,

    /// List of requirements for the position
    required List<String> requirements,

    /// Skills required for the position (from languages field)
    required List<String> skills,

    /// Type of employment (full-time, part-time, etc.)
    String? employmentType,

    /// Required experience level
    String? experienceLevel,

    /// Working hours
    String? workingHours,

    /// Working days
    String? workingDays,

    /// Contact phone number
    String? phone,

    /// Application URL
    String? applyUrl,

    /// Application email
    String? applicationEmail,

    /// Job source (where it was posted)
    String? source,

    /// Nationality requirement
    String? nationality,

    /// Gender requirement
    String? gender,

    /// Academic qualifications required
    String? academicQualification,

    /// Date when the job was posted
    String? postedDate,

    /// Is job saved by user
    bool? isSaved,
  }) = _JobDetails;

  /// Creates a [JobDetails] instance from JSON
  factory JobDetails.fromJson(Map<String, dynamic> json) =>
      _$JobDetailsFromJson(json);
}

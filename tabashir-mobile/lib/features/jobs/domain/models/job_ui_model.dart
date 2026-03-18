import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_ui_model.freezed.dart';
part 'job_ui_model.g.dart';

/// UI model for displaying job information in cards and lists
/// Maps from JobDetailsResponse to a format optimized for UI display
@freezed
sealed class JobUI with _$JobUI {
  const factory JobUI({
    /// Unique job identifier
    required String id,

    /// Job title
    required String title,

    /// Company name
    required String company,

    /// Job location
    required String location,

    /// Salary information (formatted string)
    required String salary,

    /// Match percentage (e.g., "90% Match")
    required String matchPercentage,

    /// Skills match description
    required String skillsMatch,

    /// Numeric salary value for filtering
    @Default(0) int salaryValue,

    /// Job tags (jobType, experience, languages)
    @Default([]) List<String> tags,

    /// Whether job is saved by user
    @Default(false) bool isSaved,

    /// Whether user has already applied to this job
    @Default(false) bool isApplied,

    /// Job type (Full-time, Part-time, etc.)
    String? jobType,

    /// Experience level required
    String? experienceLevel,

    /// Required skills
    @Default([]) List<String> skills,

    /// Work mode (Remote, On-site, Hybrid)
    String? workMode,

    /// Job description
    String? description,

    /// Job requirements
    @Default([]) List<String> requirements,

    /// Posted date (formatted, e.g., "2 days ago")
    String? postedDate,

    /// Working days
    String? workingDays,
  }) = _JobUI;

  factory JobUI.fromJson(Map<String, dynamic> json) => _$JobUIFromJson(json);
}

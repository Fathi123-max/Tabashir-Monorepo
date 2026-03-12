import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_update_model.freezed.dart';
part 'job_update_model.g.dart';

/// Model for updating a job posting
@freezed
sealed class JobUpdate with _$JobUpdate {
  const factory JobUpdate({
    /// Entity
    String? entity,

    /// Nationality
    String? nationality,

    /// Gender
    String? gender,

    /// Job title
    String? jobTitle,

    /// Academic qualification
    String? academicQualification,

    /// Experience
    String? experience,

    /// Languages
    String? languages,

    /// Salary
    String? salary,

    /// Vacancy city
    String? vacancyCity,

    /// Working hours
    String? workingHours,

    /// Working days
    String? workingDays,

    /// Application email
    String? applicationEmail,

    /// Job description
    String? jobDescription,

    /// Job posting date (Format: YYYY-MM-DD)
    String? jobDate,

    /// Apply URL
    String? applyUrl,

    /// Phone
    String? phone,

    /// Source
    String? source,

    /// Company Name
    String? companyName,

    /// Website URL
    String? websiteUrl,

    /// Job Type
    String? jobType,
  }) = _JobUpdate;

  factory JobUpdate.fromJson(Map<String, dynamic> json) =>
      _$JobUpdateFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_create_model.freezed.dart';
part 'job_create_model.g.dart';

/// Model for creating a new job posting
@freezed
sealed class JobCreate with _$JobCreate {
  const factory JobCreate({
    /// Job title
    required String jobTitle,

    /// Job posting date YYYY-MM-DD
    required String jobDate,

    /// Entity
    String? entity,

    /// Nationality
    String? nationality,

    /// Gender
    String? gender,

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

    /// Phone
    String? phone,

    /// Apply URL
    String? applyUrl,

    /// Company Name
    String? companyName,

    /// Website URL
    String? websiteUrl,

    /// Job Type
    String? jobType,
  }) = _JobCreate;

  factory JobCreate.fromJson(Map<String, dynamic> json) =>
      _$JobCreateFromJson(json);
}

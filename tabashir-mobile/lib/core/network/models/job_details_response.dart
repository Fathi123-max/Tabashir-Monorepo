import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_details_response.freezed.dart';
part 'job_details_response.g.dart';

/// Response model for job details
@freezed
sealed class JobDetailsResponse with _$JobDetailsResponse {
  const factory JobDetailsResponse({
    /// Job ID
    @JsonKey(name: 'id') int? jobId,

    /// Job title
    @JsonKey(name: 'job_title') String? jobTitle,

    /// Company name
    @JsonKey(name: 'entity') String? companyName,

    /// Job description
    @JsonKey(name: 'job_description') String? jobDescription,

    /// Location (city)
    @JsonKey(name: 'vacancy_city') String? location,

    /// Salary
    @JsonKey(name: 'salary') String? salary,

    /// Job type
    @JsonKey(name: 'job_type') String? jobType,

    /// Application URL
    @JsonKey(name: 'apply_url') String? applyUrl,

    /// Academic qualifications required
    @JsonKey(name: 'academic_qualification') String? academicQualification,

    /// Experience level required
    @JsonKey(name: 'experience') String? experience,

    /// Language skills required
    @JsonKey(name: 'languages') String? languages,

    /// Working hours
    @JsonKey(name: 'working_hours') String? workingHours,

    /// Working days
    @JsonKey(name: 'working_days') String? workingDays,

    /// Application email
    @JsonKey(name: 'application_email') String? applicationEmail,

    /// Job posting date
    @JsonKey(name: 'job_date') String? jobDate,

    /// Contact phone
    @JsonKey(name: 'phone') String? phone,

    /// Job source (where it was posted)
    @JsonKey(name: 'source') String? source,

    /// Nationality requirement
    @JsonKey(name: 'nationality') String? nationality,

    /// Gender requirement
    @JsonKey(name: 'gender') String? gender,

    /// Is job saved
    @JsonKey(name: 'is_saved') bool? isSaved,

    /// Match percentage for the job
    @JsonKey(name: 'match_percentage') String? matchPercentage,
  }) = _JobDetailsResponse;

  factory JobDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$JobDetailsResponseFromJson(json);
}

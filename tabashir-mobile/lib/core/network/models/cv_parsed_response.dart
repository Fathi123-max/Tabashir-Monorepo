import 'package:freezed_annotation/freezed_annotation.dart';

part 'cv_parsed_response.freezed.dart';
part 'cv_parsed_response.g.dart';

/// Response model for CV parsing
@freezed
sealed class CVParsedResponse with _$CVParsedResponse {
  const factory CVParsedResponse({
    /// Personal information
    PersonalInfo? personalInfo,

    /// Education
    List<Education>? education,

    /// Experience
    List<Experience>? experience,

    /// Skills
    List<String>? skills,
  }) = _CVParsedResponse;

  factory CVParsedResponse.fromJson(Map<String, dynamic> json) =>
      _$CVParsedResponseFromJson(json);
}

/// Personal information model
@freezed
sealed class PersonalInfo with _$PersonalInfo {
  const factory PersonalInfo({
    /// Full name
    String? fullName,

    /// Email
    String? email,

    /// Phone
    String? phone,

    /// Address
    String? address,
  }) = _PersonalInfo;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) =>
      _$PersonalInfoFromJson(json);
}

/// Education model
@freezed
sealed class Education with _$Education {
  const factory Education({
    /// Degree
    String? degree,

    /// Institution
    String? institution,

    /// Year
    String? year,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

/// Experience model
@freezed
sealed class Experience with _$Experience {
  const factory Experience({
    /// Job title
    String? jobTitle,

    /// Company
    String? company,

    /// Start date
    String? startDate,

    /// End date
    String? endDate,

    /// Description
    String? description,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}

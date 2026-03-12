import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_models.freezed.dart';
part 'resume_models.g.dart';

@freezed
sealed class ResumeData with _$ResumeData {
  const factory ResumeData({
    @Default(0) int currentStep,
    @Default(0) int resumeScore,
    PersonalDetails? personalDetails,
    ProfessionalSummary? professionalSummary,
    @Default([]) List<WorkExperience> workExperience,
    @Default([]) List<Education> education,
    @Default([]) List<Skill> skills,
  }) = _ResumeData;

  factory ResumeData.fromJson(Map<String, dynamic> json) =>
      _$ResumeDataFromJson(json);
}

@freezed
sealed class PersonalDetails with _$PersonalDetails {
  const factory PersonalDetails({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? country,
    String? city,
    @Default([]) List<SocialLink> socialLinks,
  }) = _PersonalDetails;

  factory PersonalDetails.fromJson(Map<String, dynamic> json) =>
      _$PersonalDetailsFromJson(json);
}

@freezed
sealed class SocialLink with _$SocialLink {
  const factory SocialLink({
    String? platform,
    String? url,
  }) = _SocialLink;

  factory SocialLink.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkFromJson(json);
}

@freezed
sealed class ProfessionalSummary with _$ProfessionalSummary {
  const factory ProfessionalSummary({
    String? summary,
  }) = _ProfessionalSummary;

  factory ProfessionalSummary.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalSummaryFromJson(json);
}

@freezed
sealed class WorkExperience with _$WorkExperience {
  const factory WorkExperience({
    String? position,
    String? organization,
    String? city,
    String? keyTasks,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isPresent,
  }) = _WorkExperience;

  factory WorkExperience.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceFromJson(json);
}

@freezed
sealed class Education with _$Education {
  const factory Education({
    String? school,
    String? degree,
    String? city,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

enum SkillCategory {
  technical,
  soft,
  languages,
}

enum ProficiencyLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

@freezed
sealed class Skill with _$Skill {
  const factory Skill({
    String? name,
    SkillCategory? category,
    ProficiencyLevel? proficiency,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

class BuilderStep {
  const BuilderStep._();
  static const int personalDetails = 0;
  static const int professionalSummary = 1;
  static const int workExperience = 2;
  static const int education = 3;
  static const int skills = 4;
}

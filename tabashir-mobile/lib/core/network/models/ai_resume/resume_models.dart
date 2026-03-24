import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_models.freezed.dart';
part 'resume_models.g.dart';

@freezed
sealed class ResumeData with _$ResumeData {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ResumeData({
    @Default(0) int currentStep,
    @Default(0) int resumeScore,
    @JsonKey(name: 'header') PersonalDetails? personalDetails,
    @JsonKey(name: 'objective') ProfessionalSummary? professionalSummary,
    @JsonKey(name: 'work') @Default([]) List<WorkExperience> workExperience,
    @Default([]) List<WorkExperience> leadership,
    @Default([]) List<Education> education,
    @Default([]) List<Skill> skills,
    @Default([]) List<Project> projects,
    @Default([]) List<Language> languages,
  }) = _ResumeData;

  factory ResumeData.fromJson(Map<String, dynamic> json) =>
      _$ResumeDataFromJson(json);
}

@freezed
sealed class PersonalDetails with _$PersonalDetails {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory PersonalDetails({
    @JsonKey(name: 'name') String? fullName,
    String? email,
    @JsonKey(name: 'phone') String? phoneNumber,
    @JsonKey(name: 'location') String? country,
    String? city,
    String? linkedin,
    String? github,
    String? nationality,
    @Default([]) List<SocialLink> socialLinks,
  }) = _PersonalDetails;

  factory PersonalDetails.fromJson(Map<String, dynamic> json) =>
      _$PersonalDetailsFromJson(json);
}

@freezed
sealed class SocialLink with _$SocialLink {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SocialLink({
    String? platform,
    String? url,
  }) = _SocialLink;

  factory SocialLink.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkFromJson(json);
}

@freezed
sealed class ProfessionalSummary with _$ProfessionalSummary {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ProfessionalSummary({
    @JsonKey(name: 'objective') String? summary,
  }) = _ProfessionalSummary;

  factory ProfessionalSummary.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalSummaryFromJson(json);
}

@freezed
sealed class WorkExperience with _$WorkExperience {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory WorkExperience({
    String? position,
    @JsonKey(name: 'company') String? organization,
    @JsonKey(name: 'location') String? city,
    @JsonKey(name: 'details') String? keyTasks,
    DateTime? startDate,
    DateTime? endDate,
    @Default(false) bool isPresent,
    @JsonKey(name: 'date') String? dateString,
  }) = _WorkExperience;

  factory WorkExperience.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceFromJson(json);
}

@freezed
sealed class Education with _$Education {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Education({
    String? school,
    String? degree,
    @JsonKey(name: 'location') String? city,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
    String? university,
    String? major,
    @JsonKey(name: 'GPA') String? gpa,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

@freezed
sealed class Project with _$Project {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Project({
    String? name,
    String? description,
    String? url,
    List<String>? highlights,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);
}

@freezed
sealed class Language with _$Language {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Language({
    String? name,
    String? proficiency,
  }) = _Language;

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
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
  @JsonSerializable(fieldRename: FieldRename.snake)
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
  static const int templateSelection = 5;
}

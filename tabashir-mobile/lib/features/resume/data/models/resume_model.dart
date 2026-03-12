import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_model.freezed.dart';
part 'resume_model.g.dart';

@freezed
sealed class Resume with _$Resume {
  const factory Resume({
    required String id,
    required String userId,
    required String title,
    required String fullName,
    required String email,
    String? phone,
    String? summary,
    @Default([]) List<WorkExperience> experience,
    @Default([]) List<Education> education,
    @Default([]) List<Skill> skills,
    @Default([]) List<String> certifications,
    @Default([]) List<String> languages,
    String? profileImageUrl,
    @Default(ResumeStatus.draft) ResumeStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Resume;

  factory Resume.fromJson(Map<String, dynamic> json) => _$ResumeFromJson(json);
}

enum ResumeStatus {
  draft,
  active,
  archived,
}

@freezed
sealed class WorkExperience with _$WorkExperience {
  const factory WorkExperience({
    required String company,
    required String position,
    required DateTime startDate,
    DateTime? endDate,
    @Default(false) bool isCurrent,
    String? description,
    String? location,
  }) = _WorkExperience;

  factory WorkExperience.fromJson(Map<String, dynamic> json) =>
      _$WorkExperienceFromJson(json);
}

@freezed
sealed class Education with _$Education {
  const factory Education({
    required String institution,
    required String degree,
    required DateTime startDate,
    DateTime? endDate,
    String? fieldOfStudy,
    String? gpa,
  }) = _Education;

  factory Education.fromJson(Map<String, dynamic> json) =>
      _$EducationFromJson(json);
}

@freezed
sealed class Skill with _$Skill {
  const factory Skill({
    required String name,
    required SkillLevel level,
    required String category, // Technical, Soft, Language, etc.
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}

enum SkillLevel {
  beginner,
  intermediate,
  advanced,
  expert,
}

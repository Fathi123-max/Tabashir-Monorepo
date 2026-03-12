import 'package:freezed_annotation/freezed_annotation.dart';

part 'professional_info_request.freezed.dart';
part 'professional_info_request.g.dart';

/// Professional info update request model
@freezed
sealed class ProfessionalInfoRequest with _$ProfessionalInfoRequest {
  const factory ProfessionalInfoRequest({
    required String summary,
    String? jobType,
    String? experience,
    String? education,
    String? degree,
    List<EmploymentHistoryItem>? employmentHistory,
    List<EducationItem>? educationList,
    List<SkillItem>? skills,
    List<LanguageItem>? languages,
  }) = _ProfessionalInfoRequest;

  factory ProfessionalInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfessionalInfoRequestFromJson(json);
}

/// Employment history item
@freezed
sealed class EmploymentHistoryItem with _$EmploymentHistoryItem {
  const factory EmploymentHistoryItem({
    String? company,
    String? position,
    String? startDate,
    String? endDate,
    String? country,
    String? city,
    bool? current,
    String? description,
    List<String>? achievements,
  }) = _EmploymentHistoryItem;

  factory EmploymentHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$EmploymentHistoryItemFromJson(json);
}

/// Education item
@freezed
sealed class EducationItem with _$EducationItem {
  const factory EducationItem({
    String? institution,
    String? degree,
    String? field,
    String? city,
    String? startDate,
    String? endDate,
    bool? current,
    double? gpa,
    List<String>? achievements,
  }) = _EducationItem;

  factory EducationItem.fromJson(Map<String, dynamic> json) =>
      _$EducationItemFromJson(json);
}

/// Skill item
@freezed
sealed class SkillItem with _$SkillItem {
  const factory SkillItem({
    required String category,
    required String name,
    String? level,
  }) = _SkillItem;

  factory SkillItem.fromJson(Map<String, dynamic> json) =>
      _$SkillItemFromJson(json);
}

/// Language item
@freezed
sealed class LanguageItem with _$LanguageItem {
  const factory LanguageItem({
    required String name,
    required String proficiency,
  }) = _LanguageItem;

  factory LanguageItem.fromJson(Map<String, dynamic> json) =>
      _$LanguageItemFromJson(json);
}

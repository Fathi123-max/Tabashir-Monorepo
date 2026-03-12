// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeData _$ResumeDataFromJson(Map<String, dynamic> json) => _ResumeData(
  currentStep: (json['currentStep'] as num?)?.toInt() ?? 0,
  resumeScore: (json['resumeScore'] as num?)?.toInt() ?? 0,
  personalDetails: json['personalDetails'] == null
      ? null
      : PersonalDetails.fromJson(
          json['personalDetails'] as Map<String, dynamic>,
        ),
  professionalSummary: json['professionalSummary'] == null
      ? null
      : ProfessionalSummary.fromJson(
          json['professionalSummary'] as Map<String, dynamic>,
        ),
  workExperience:
      (json['workExperience'] as List<dynamic>?)
          ?.map((e) => WorkExperience.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  education:
      (json['education'] as List<dynamic>?)
          ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  skills:
      (json['skills'] as List<dynamic>?)
          ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ResumeDataToJson(_ResumeData instance) =>
    <String, dynamic>{
      'currentStep': instance.currentStep,
      'resumeScore': instance.resumeScore,
      'personalDetails': instance.personalDetails,
      'professionalSummary': instance.professionalSummary,
      'workExperience': instance.workExperience,
      'education': instance.education,
      'skills': instance.skills,
    };

_PersonalDetails _$PersonalDetailsFromJson(Map<String, dynamic> json) =>
    _PersonalDetails(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      socialLinks:
          (json['socialLinks'] as List<dynamic>?)
              ?.map((e) => SocialLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PersonalDetailsToJson(_PersonalDetails instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'country': instance.country,
      'city': instance.city,
      'socialLinks': instance.socialLinks,
    };

_SocialLink _$SocialLinkFromJson(Map<String, dynamic> json) => _SocialLink(
  platform: json['platform'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$SocialLinkToJson(_SocialLink instance) =>
    <String, dynamic>{'platform': instance.platform, 'url': instance.url};

_ProfessionalSummary _$ProfessionalSummaryFromJson(Map<String, dynamic> json) =>
    _ProfessionalSummary(summary: json['summary'] as String?);

Map<String, dynamic> _$ProfessionalSummaryToJson(
  _ProfessionalSummary instance,
) => <String, dynamic>{'summary': instance.summary};

_WorkExperience _$WorkExperienceFromJson(Map<String, dynamic> json) =>
    _WorkExperience(
      position: json['position'] as String?,
      organization: json['organization'] as String?,
      city: json['city'] as String?,
      keyTasks: json['keyTasks'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      isPresent: json['isPresent'] as bool? ?? false,
    );

Map<String, dynamic> _$WorkExperienceToJson(_WorkExperience instance) =>
    <String, dynamic>{
      'position': instance.position,
      'organization': instance.organization,
      'city': instance.city,
      'keyTasks': instance.keyTasks,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'isPresent': instance.isPresent,
    };

_Education _$EducationFromJson(Map<String, dynamic> json) => _Education(
  school: json['school'] as String?,
  degree: json['degree'] as String?,
  city: json['city'] as String?,
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  endDate: json['endDate'] == null
      ? null
      : DateTime.parse(json['endDate'] as String),
  description: json['description'] as String?,
);

Map<String, dynamic> _$EducationToJson(_Education instance) =>
    <String, dynamic>{
      'school': instance.school,
      'degree': instance.degree,
      'city': instance.city,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'description': instance.description,
    };

_Skill _$SkillFromJson(Map<String, dynamic> json) => _Skill(
  name: json['name'] as String?,
  category: $enumDecodeNullable(_$SkillCategoryEnumMap, json['category']),
  proficiency: $enumDecodeNullable(
    _$ProficiencyLevelEnumMap,
    json['proficiency'],
  ),
);

Map<String, dynamic> _$SkillToJson(_Skill instance) => <String, dynamic>{
  'name': instance.name,
  'category': _$SkillCategoryEnumMap[instance.category],
  'proficiency': _$ProficiencyLevelEnumMap[instance.proficiency],
};

const _$SkillCategoryEnumMap = {
  SkillCategory.technical: 'technical',
  SkillCategory.soft: 'soft',
  SkillCategory.languages: 'languages',
};

const _$ProficiencyLevelEnumMap = {
  ProficiencyLevel.beginner: 'beginner',
  ProficiencyLevel.intermediate: 'intermediate',
  ProficiencyLevel.advanced: 'advanced',
  ProficiencyLevel.expert: 'expert',
};

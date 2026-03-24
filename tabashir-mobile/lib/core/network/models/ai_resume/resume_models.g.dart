// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeData _$ResumeDataFromJson(Map<String, dynamic> json) => _ResumeData(
  currentStep: (json['current_step'] as num?)?.toInt() ?? 0,
  resumeScore: (json['resume_score'] as num?)?.toInt() ?? 0,
  personalDetails: json['header'] == null
      ? null
      : PersonalDetails.fromJson(json['header'] as Map<String, dynamic>),
  professionalSummary: json['objective'] == null
      ? null
      : ProfessionalSummary.fromJson(json['objective'] as Map<String, dynamic>),
  workExperience:
      (json['work'] as List<dynamic>?)
          ?.map((e) => WorkExperience.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  leadership:
      (json['leadership'] as List<dynamic>?)
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
  projects:
      (json['projects'] as List<dynamic>?)
          ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)
          ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ResumeDataToJson(_ResumeData instance) =>
    <String, dynamic>{
      'current_step': instance.currentStep,
      'resume_score': instance.resumeScore,
      'header': instance.personalDetails,
      'objective': instance.professionalSummary,
      'work': instance.workExperience,
      'leadership': instance.leadership,
      'education': instance.education,
      'skills': instance.skills,
      'projects': instance.projects,
      'languages': instance.languages,
    };

_PersonalDetails _$PersonalDetailsFromJson(Map<String, dynamic> json) =>
    _PersonalDetails(
      fullName: json['name'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone'] as String?,
      country: json['location'] as String?,
      city: json['city'] as String?,
      linkedin: json['linkedin'] as String?,
      github: json['github'] as String?,
      nationality: json['nationality'] as String?,
      socialLinks:
          (json['social_links'] as List<dynamic>?)
              ?.map((e) => SocialLink.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PersonalDetailsToJson(_PersonalDetails instance) =>
    <String, dynamic>{
      'name': instance.fullName,
      'email': instance.email,
      'phone': instance.phoneNumber,
      'location': instance.country,
      'city': instance.city,
      'linkedin': instance.linkedin,
      'github': instance.github,
      'nationality': instance.nationality,
      'social_links': instance.socialLinks,
    };

_SocialLink _$SocialLinkFromJson(Map<String, dynamic> json) => _SocialLink(
  platform: json['platform'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$SocialLinkToJson(_SocialLink instance) =>
    <String, dynamic>{'platform': instance.platform, 'url': instance.url};

_ProfessionalSummary _$ProfessionalSummaryFromJson(Map<String, dynamic> json) =>
    _ProfessionalSummary(summary: json['objective'] as String?);

Map<String, dynamic> _$ProfessionalSummaryToJson(
  _ProfessionalSummary instance,
) => <String, dynamic>{'objective': instance.summary};

_WorkExperience _$WorkExperienceFromJson(Map<String, dynamic> json) =>
    _WorkExperience(
      position: json['position'] as String?,
      organization: json['company'] as String?,
      city: json['location'] as String?,
      keyTasks: json['details'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      isPresent: json['is_present'] as bool? ?? false,
      dateString: json['date'] as String?,
    );

Map<String, dynamic> _$WorkExperienceToJson(_WorkExperience instance) =>
    <String, dynamic>{
      'position': instance.position,
      'company': instance.organization,
      'location': instance.city,
      'details': instance.keyTasks,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'is_present': instance.isPresent,
      'date': instance.dateString,
    };

_Education _$EducationFromJson(Map<String, dynamic> json) => _Education(
  school: json['school'] as String?,
  degree: json['degree'] as String?,
  city: json['location'] as String?,
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  description: json['description'] as String?,
  university: json['university'] as String?,
  major: json['major'] as String?,
  gpa: json['GPA'] as String?,
);

Map<String, dynamic> _$EducationToJson(_Education instance) =>
    <String, dynamic>{
      'school': instance.school,
      'degree': instance.degree,
      'location': instance.city,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'description': instance.description,
      'university': instance.university,
      'major': instance.major,
      'GPA': instance.gpa,
    };

_Project _$ProjectFromJson(Map<String, dynamic> json) => _Project(
  name: json['name'] as String?,
  description: json['description'] as String?,
  url: json['url'] as String?,
  highlights: (json['highlights'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ProjectToJson(_Project instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'url': instance.url,
  'highlights': instance.highlights,
};

_Language _$LanguageFromJson(Map<String, dynamic> json) => _Language(
  name: json['name'] as String?,
  proficiency: json['proficiency'] as String?,
);

Map<String, dynamic> _$LanguageToJson(_Language instance) => <String, dynamic>{
  'name': instance.name,
  'proficiency': instance.proficiency,
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

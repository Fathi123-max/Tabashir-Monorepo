// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobDetails _$JobDetailsFromJson(Map<String, dynamic> json) => _JobDetails(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  company: json['company'] as String,
  industry: json['industry'] as String,
  location: json['location'] as String,
  salary: json['salary'] as String,
  matchPercentage: json['matchPercentage'] as String,
  companySize: (json['companySize'] as num).toInt(),
  foundedYear: (json['foundedYear'] as num).toInt(),
  isVerified: json['isVerified'] as bool,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  responsibilities: (json['responsibilities'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  requirements: (json['requirements'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  skills: (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
  similarOpportunities: (json['similarOpportunities'] as List<dynamic>)
      .map((e) => SimilarJob.fromJson(e as Map<String, dynamic>))
      .toList(),
  overview: json['overview'] as String?,
  benefits: json['benefits'] as String?,
  employmentType: json['employmentType'] as String?,
  experienceLevel: json['experienceLevel'] as String?,
  postedDate: json['postedDate'] as String?,
);

Map<String, dynamic> _$JobDetailsToJson(_JobDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'company': instance.company,
      'industry': instance.industry,
      'location': instance.location,
      'salary': instance.salary,
      'matchPercentage': instance.matchPercentage,
      'companySize': instance.companySize,
      'foundedYear': instance.foundedYear,
      'isVerified': instance.isVerified,
      'tags': instance.tags,
      'responsibilities': instance.responsibilities,
      'requirements': instance.requirements,
      'skills': instance.skills,
      'similarOpportunities': instance.similarOpportunities,
      'overview': instance.overview,
      'benefits': instance.benefits,
      'employmentType': instance.employmentType,
      'experienceLevel': instance.experienceLevel,
      'postedDate': instance.postedDate,
    };

_SimilarJob _$SimilarJobFromJson(Map<String, dynamic> json) => _SimilarJob(
  id: json['id'] as String,
  title: json['title'] as String,
  company: json['company'] as String,
  matchPercentage: json['matchPercentage'] as String,
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$SimilarJobToJson(_SimilarJob instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'company': instance.company,
      'matchPercentage': instance.matchPercentage,
      'tags': instance.tags,
    };

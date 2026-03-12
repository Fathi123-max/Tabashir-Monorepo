// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recruiter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecruiterProfile _$RecruiterProfileFromJson(Map<String, dynamic> json) =>
    _RecruiterProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      company: json['company'] as String,
      position: json['position'] as String,
      phone: json['phone'] as String?,
      bio: json['bio'] as String?,
      postedJobs:
          (json['postedJobs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$RecruiterProfileToJson(_RecruiterProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'company': instance.company,
      'position': instance.position,
      'phone': instance.phone,
      'bio': instance.bio,
      'postedJobs': instance.postedJobs,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_JobPosting _$JobPostingFromJson(Map<String, dynamic> json) => _JobPosting(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  company: json['company'] as String,
  location: json['location'] as String,
  employmentType: json['employmentType'] as String,
  salaryMin: (json['salaryMin'] as num).toDouble(),
  salaryMax: (json['salaryMax'] as num).toDouble(),
  recruiterId: json['recruiterId'] as String,
  requirements:
      (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  status:
      $enumDecodeNullable(_$JobStatusEnumMap, json['status']) ??
      JobStatus.draft,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$JobPostingToJson(_JobPosting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'company': instance.company,
      'location': instance.location,
      'employmentType': instance.employmentType,
      'salaryMin': instance.salaryMin,
      'salaryMax': instance.salaryMax,
      'recruiterId': instance.recruiterId,
      'requirements': instance.requirements,
      'tags': instance.tags,
      'status': _$JobStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$JobStatusEnumMap = {
  JobStatus.draft: 'draft',
  JobStatus.active: 'active',
  JobStatus.paused: 'paused',
  JobStatus.closed: 'closed',
};

_JobApplication _$JobApplicationFromJson(Map<String, dynamic> json) =>
    _JobApplication(
      id: json['id'] as String,
      jobId: json['jobId'] as String,
      candidateId: json['candidateId'] as String,
      candidateName: json['candidateName'] as String,
      candidateEmail: json['candidateEmail'] as String,
      candidateResumeUrl: json['candidateResumeUrl'] as String?,
      status:
          $enumDecodeNullable(_$ApplicationStatusEnumMap, json['status']) ??
          ApplicationStatus.pending,
      notes: json['notes'] as String?,
      appliedAt: json['appliedAt'] == null
          ? null
          : DateTime.parse(json['appliedAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$JobApplicationToJson(_JobApplication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobId': instance.jobId,
      'candidateId': instance.candidateId,
      'candidateName': instance.candidateName,
      'candidateEmail': instance.candidateEmail,
      'candidateResumeUrl': instance.candidateResumeUrl,
      'status': _$ApplicationStatusEnumMap[instance.status]!,
      'notes': instance.notes,
      'appliedAt': instance.appliedAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.pending: 'pending',
  ApplicationStatus.review: 'review',
  ApplicationStatus.interview: 'interview',
  ApplicationStatus.offered: 'offered',
  ApplicationStatus.rejected: 'rejected',
  ApplicationStatus.withdrawn: 'withdrawn',
};

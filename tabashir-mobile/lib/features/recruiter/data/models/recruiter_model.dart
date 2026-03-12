import 'package:freezed_annotation/freezed_annotation.dart';

part 'recruiter_model.freezed.dart';
part 'recruiter_model.g.dart';

@freezed
sealed class RecruiterProfile with _$RecruiterProfile {
  const factory RecruiterProfile({
    required String id,
    required String name,
    required String email,
    required String company,
    required String position,
    String? phone,
    String? bio,
    @Default([]) List<String> postedJobs,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RecruiterProfile;

  factory RecruiterProfile.fromJson(Map<String, dynamic> json) =>
      _$RecruiterProfileFromJson(json);
}

@freezed
sealed class JobPosting with _$JobPosting {
  const factory JobPosting({
    required String id,
    required String title,
    required String description,
    required String company,
    required String location,
    required String employmentType, // Full-time, Part-time, Contract
    required double salaryMin,
    required double salaryMax,
    required String recruiterId,
    @Default([]) List<String> requirements,
    @Default([]) List<String> tags,
    @Default(JobStatus.draft) JobStatus status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _JobPosting;

  factory JobPosting.fromJson(Map<String, dynamic> json) =>
      _$JobPostingFromJson(json);
}

enum JobStatus {
  draft,
  active,
  paused,
  closed,
}

@freezed
sealed class JobApplication with _$JobApplication {
  const factory JobApplication({
    required String id,
    required String jobId,
    required String candidateId,
    required String candidateName,
    required String candidateEmail,
    String? candidateResumeUrl,
    @Default(ApplicationStatus.pending) ApplicationStatus status,
    String? notes,
    DateTime? appliedAt,
    DateTime? updatedAt,
  }) = _JobApplication;

  factory JobApplication.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationFromJson(json);
}

enum ApplicationStatus {
  pending,
  review,
  interview,
  offered,
  rejected,
  withdrawn,
}

part of 'recruiter_cubit.dart';

@freezed
sealed class RecruiterState with _$RecruiterState {
  const factory RecruiterState({
    @Default(RecruiterStatus.initial) RecruiterStatus status,
    @Default('') String errorMessage,
    RecruiterProfile? profile,
    @Default([]) List<JobPosting> jobPostings,
    @Default([]) List<JobApplication> applications,
    JobPosting? currentJobPosting,
    @Default([]) List<JobApplication> jobApplications,
  }) = _RecruiterState;

  factory RecruiterState.fromJson(Map<String, dynamic> json) =>
      _$RecruiterStateFromJson(json);
}

enum RecruiterStatus {
  initial,
  loading,
  loaded,
  error,
}

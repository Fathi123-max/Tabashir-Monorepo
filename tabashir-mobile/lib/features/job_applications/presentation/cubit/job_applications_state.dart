part of 'job_applications_cubit.dart';

@freezed
sealed class JobApplicationsState with _$JobApplicationsState {
  const factory JobApplicationsState({
    @Default(JobApplicationsStatus.initial) JobApplicationsStatus status,
    @Default([]) List<AppliedJob> appliedJobs,
    @Default(0) int totalApplications,
    @Default('') String errorMessage,
  }) = _JobApplicationsState;

  factory JobApplicationsState.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationsStateFromJson(json);
}

enum JobApplicationsStatus {
  initial,
  loading,
  success,
  error,
}

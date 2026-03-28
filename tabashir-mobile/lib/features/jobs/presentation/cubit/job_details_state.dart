part of 'job_details_cubit.dart';

@freezed
class JobDetailsState with _$JobDetailsState {
  const factory JobDetailsState.initial() = JobDetailsInitial;
  const factory JobDetailsState.loading() = JobDetailsLoading;
  const factory JobDetailsState.loaded({
    required JobDetails jobDetails,
    @Default(false) bool isApplied,
    @Default(false) bool isSaved,
  }) = JobDetailsLoaded;
  const factory JobDetailsState.error(String message) = JobDetailsError;
}

part of 'saved_jobs_cubit.dart';

@freezed
class SavedJobsState with _$SavedJobsState {
  const factory SavedJobsState.initial() = SavedJobsStateInitial;

  const factory SavedJobsState.loaded({
    required List<Map<String, dynamic>> jobs,
    required Set<String> savedJobs,
    required String cardStyle,
    required bool isGridView,
    required String searchQuery,
  }) = SavedJobsStateLoaded;

  const factory SavedJobsState.loading() = SavedJobsStateLoading;

  const factory SavedJobsState.error(String message) = SavedJobsStateError;
}

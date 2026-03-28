part of 'jobs_cubit.dart';

@freezed
class JobsState with _$JobsState {
  const factory JobsState.initial() = JobsStateInitial;

  const factory JobsState.loaded({
    @Default('Relevance') String selectedSort,
    @Default(true) bool isGridView,
    @Default(true) bool showBanner,
    @Default('') String searchQuery,
    @Default('standard') String cardStyle,
    @Default([]) List<JobUI> jobs,
    @Default([]) List<String> selectedLocations,
    @Default([]) List<String> selectedJobTypes,
    @Default([]) List<String> selectedExperienceLevels,
    @Default(0) int minSalary,
    @Default(100000) int maxSalary,
    @Default(<String>{}) Set<String> savedJobs,
    // Pagination fields
    @Default(0) int currentPage,
    @Default(0) int totalJobs,
    @Default(20) int itemsPerPage,
    @Default(true) bool hasMoreData,
    @Default(false) bool isLoadingMore,
  }) = JobsStateLoaded;
}

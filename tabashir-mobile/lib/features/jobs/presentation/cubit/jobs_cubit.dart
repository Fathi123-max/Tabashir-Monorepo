import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:tabashir/core/network/models/job_details_response.dart';
import 'package:tabashir/core/services/applied_jobs_storage.dart';
import 'package:tabashir/core/services/isar_service.dart';
import 'package:tabashir/features/jobs/domain/models/job_ui_model.dart';
import 'package:tabashir/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';

part 'jobs_state.dart';
part 'jobs_cubit.freezed.dart';

@injectable
class JobsCubit extends Cubit<JobsState> {
  JobsCubit(
    this._repository,
    this._savedJobsRepository,
    this._appliedJobsStorage,
    this._profileCubit,
  ) : super(const JobsState.initial()) {
    print('[JOBS_CUBIT] Cubit created');
    _savedJobsSubscription = _savedJobsRepository.savedJobsStream.listen((
      savedIds,
    ) {
      print('[JOBS_CUBIT] Received saved jobs update: ${savedIds.length} IDs');
      _updateJobsWithSavedStatus(savedIds);
    });
    _seedAppliedJobsFromCache();
  }

  final JobsRepository _repository;
  final SavedJobsRepository _savedJobsRepository;
  final AppliedJobsStorage _appliedJobsStorage;
  final ProfileCubit _profileCubit;
  StreamSubscription<Set<String>>? _savedJobsSubscription;
  Set<String> _appliedJobIds = {};
  bool _isInitialized = false;

  @override
  Future<void> close() {
    _savedJobsSubscription?.cancel();
    _searchDebounceTimer?.cancel();
    return super.close();
  }

  Timer? _searchDebounceTimer;

  /// Initialize the cubit state
  /// Only loads jobs if not already initialized
  void initializeState({String? initialCity}) {
    if (_isInitialized) {
      if (initialCity != null && state is JobsStateLoaded) {
        final loadedState = state as JobsStateLoaded;
        emit(
          loadedState.copyWith(
            selectedLocations: [initialCity],
            searchQuery: '',
            selectedJobTypes: [],
            selectedExperienceLevels: [],
            minSalary: 0,
            maxSalary: 100000,
          ),
        );
        loadJobs(page: 0);
      }
      print('[JOBS_CUBIT] Already initialized, skipping duplicate load');
      return;
    }
    print('[JOBS_CUBIT] initializeState() called - Will load jobs');
    _isInitialized = true;

    if (initialCity != null) {
      emit(
        JobsState.loaded(
          selectedLocations: [initialCity],
        ),
      );
    }

    loadJobs();
  }

  // Filter options
  final List<String> locationOptions = [
    'Remote',
    'On-site',
    'Hybrid',
    'Dubai',
    'Abu Dhabi',
    'Riyadh',
    'Sharjah',
    'Doha',
    'Jeddah',
    'Muscat',
    'Ajman',
  ];

  final List<String> jobTypeOptions = [
    'Full-time',
    'Part-time',
    'Contract',
    'Internship',
    'Remote',
  ];

  final List<String> experienceLevelOptions = [
    'Entry-Level',
    'Mid-Level',
    'Senior',
    'Lead',
  ];

  /// Load jobs from API with pagination (resets list)
  Future<void> loadJobs({
    int page = 0,
    int limit = 20,
  }) async {
    try {
      print('[JOBS_CUBIT] loadJobs() called - Page: $page, Limit: $limit');
      print('[JOBS_CUBIT] Current state: $state');

      // Get current filters from state
      String? search;
      List<String>? locations;
      List<String>? jobTypes;
      List<String>? experienceLevels;
      int? minSalary;
      int? maxSalary;
      String? sort;

      if (state is JobsStateLoaded) {
        final loadedState = state as JobsStateLoaded;
        search = loadedState.searchQuery.isNotEmpty
            ? loadedState.searchQuery
            : null;
        locations = loadedState.selectedLocations.isNotEmpty
            ? loadedState.selectedLocations
            : null;
        jobTypes = loadedState.selectedJobTypes.isNotEmpty
            ? loadedState.selectedJobTypes
            : null;
        experienceLevels = loadedState.selectedExperienceLevels.isNotEmpty
            ? loadedState.selectedExperienceLevels
            : null;
        minSalary = loadedState.minSalary > 0 ? loadedState.minSalary : null;
        maxSalary = loadedState.maxSalary < 100000
            ? loadedState.maxSalary
            : null;
        sort = loadedState.selectedSort;
      }

      // Get user email from profile cubit to exclude applied jobs
      final userEmail = _profileCubit.state.profile?.email;

      // Get jobs from repository with pagination, search, and filters
      final jobs = await _repository.getJobs(
        page: page,
        limit: limit,
        search: search,
        locations: locations,
        jobTypes: jobTypes,
        experienceLevels: experienceLevels,
        minSalary: minSalary,
        maxSalary: maxSalary,
        sort: sort,
        email: userEmail,
      );

      print('[JOBS_CUBIT] API response received - ${jobs.length} jobs');

      // Sync jobs to local database
      try {
        final jobsToSync = jobs
            .map(
              (job) => {
                'id': job.jobId?.toString(),
                'title': job.jobTitle,
                'company': job.companyName,
                'location': job.location,
                'description': job.jobDescription,
              },
            )
            .where((job) => job['id'] != null)
            .toList();
        await _savedJobsRepository.syncJobs(jobsToSync);
        print(
          '[JOBS_CUBIT] Synced ${jobsToSync.length} jobs to local database',
        );
      } catch (e) {
        print('[JOBS_CUBIT] Failed to sync jobs: $e');
      }

      // Load saved job IDs
      final savedJobIds = await _savedJobsRepository.getAllSavedJobIds();
      print('[JOBS_CUBIT] Loaded ${savedJobIds.length} saved job IDs');
      final savedJobsSet = savedJobIds.toSet();

      // Convert API response to UI format
      final jobsForUI = jobs
          .map((job) => _mapJobToUI(job, savedJobsSet))
          .toList();

      print('[JOBS_CUBIT] Mapped ${jobsForUI.length} jobs for UI');

      // Calculate pagination info
      final hasMore = jobs.length == limit;
      final totalJobs = page == 0
          ? jobs.length
          : (state is JobsStateLoaded
                    ? (state as JobsStateLoaded).totalJobs
                    : 0) +
                jobs.length;

      // Handle different state types
      if (state is JobsStateLoaded) {
        // Merge with existing state
        final loadedState = state as JobsStateLoaded;
        emit(
          loadedState.copyWith(
            jobs: page == 0 ? jobsForUI : [...loadedState.jobs, ...jobsForUI],
            currentPage: page,
            hasMoreData: hasMore,
            totalJobs: totalJobs,
            isLoadingMore: false,
          ),
        );
      } else {
        // Initial state - create new loaded state
        emit(
          JobsState.loaded(
            jobs: jobsForUI,
            currentPage: page,
            hasMoreData: hasMore,
            totalJobs: totalJobs,
          ),
        );
      }

      print(
        '[JOBS_CUBIT] Successfully emitted JobsState.loaded with pagination - Page: $page, HasMore: $hasMore, Total: $totalJobs',
      );
    } catch (e, stackTrace) {
      print('[JOBS_CUBIT] ❌ ERROR loading jobs: $e');
      print('[JOBS_CUBIT] StackTrace: $stackTrace');
      print('[JOBS_CUBIT] Current state: $state');

      // Emit state with isLoadingMore reset to false
      if (state is JobsStateLoaded) {
        emit(
          (state as JobsStateLoaded).copyWith(
            isLoadingMore: false,
          ),
        );
      } else {
        emit(const JobsState.initial());
      }
    }
  }

  /// Load more jobs for pagination (appends to existing list)
  Future<void> loadMoreJobs() async {
    if (state is! JobsStateLoaded) return;

    final loadedState = state as JobsStateLoaded;

    // Don't load more if already loading or no more data
    if (loadedState.isLoadingMore || !loadedState.hasMoreData) {
      print(
        '[JOBS_CUBIT] loadMoreJobs() skipped - LoadingMore: ${loadedState.isLoadingMore}, HasMore: ${loadedState.hasMoreData}',
      );
      return;
    }

    print(
      '[JOBS_CUBIT] loadMoreJobs() called - Current page: ${loadedState.currentPage}',
    );

    // Set loading state
    emit(loadedState.copyWith(isLoadingMore: true));

    // Load next page
    await loadJobs(
      page: loadedState.currentPage + 1,
      limit: loadedState.itemsPerPage,
    );
  }

  /// Refresh jobs by reloading from page 0
  /// This is used for pull-to-refresh functionality
  Future<void> refreshJobs() async {
    print('[JOBS_CUBIT] refreshJobs() called - Reloading from page 0');
    await loadJobs();
  }

  /// Map API job response to UI format
  JobUI _mapJobToUI(JobDetailsResponse job, Set<String> savedJobIds) {
    // Build tags from available API fields
    final tags = <String>[];
    if (job.jobType != null && job.jobType!.isNotEmpty) {
      tags.add(job.jobType!);
    }
    if (job.experience != null && job.experience!.isNotEmpty) {
      tags.add(job.experience!);
    }
    if (job.languages != null && job.languages!.isNotEmpty) {
      tags.add(job.languages!);
    }

    // Format posting date
    final postedDate = _formatJobDate(job.jobDate);

    return JobUI(
      id: job.jobId?.toString() ?? 'unknown',
      title: job.jobTitle ?? 'Untitled Position',
      company: job.companyName ?? 'Unknown Company',
      location: job.location ?? 'Not specified',
      salary: _formatSalaryDisplay(job.salary),
      salaryValue: _extractSalaryValue(job.salary),
      matchPercentage: '90% Match', // TODO: Calculate from backend
      tags: tags,
      skillsMatch: job.academicQualification ?? 'Qualifications pending',
      isSaved:
          job.isSaved == true || savedJobIds.contains(job.jobId?.toString()),
      isApplied: _appliedJobIds.contains(job.jobId?.toString()),
      jobType: job.jobType ?? 'Full-time',
      experienceLevel: job.experience ?? 'Not specified',
      skills: [],
      workMode: job.workingHours ?? 'Not specified',
      description: job.jobDescription ?? 'No description available',
      requirements: [],
      postedDate: postedDate,
      workingDays: job.workingDays,
    );
  }

  /// Format salary for display (replace $ with AED)
  String _formatSalaryDisplay(String? salary) {
    if (salary == null || salary.isEmpty || salary == 'Not specified') {
      return 'Salary not specified';
    }
    return salary.replaceAll('\$', 'AED ');
  }

  /// Format job date to relative time (e.g., "2 days ago")
  String _formatJobDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      final date = DateTime.tryParse(dateStr);
      if (date == null) return dateStr;
      final now = DateTime.now();
      final diff = now.difference(date);
      if (diff.inDays == 0) return 'Today';
      if (diff.inDays == 1) return '1 day ago';
      if (diff.inDays < 7) return '${diff.inDays} days ago';
      if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} weeks ago';
      return '${(diff.inDays / 30).floor()} months ago';
    } catch (_) {
      return dateStr;
    }
  }

  /// Extract numeric salary value for filtering
  int _extractSalaryValue(String? salary) {
    if (salary == null) return 0;
    // Extract numbers from strings like "$100k - $140k"
    final numbers = salary.replaceAll(RegExp('[^0-9]'), '');
    return numbers.isNotEmpty ? int.tryParse(numbers) ?? 0 : 0;
  }

  void toggleGridView() {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(
        loadedState.copyWith(
          isGridView: !loadedState.isGridView,
        ),
      );
    }
  }

  void updateSortOption(String sortOption) {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(loadedState.copyWith(selectedSort: sortOption));
      // Trigger reload with new sort option
      loadJobs();
    }
  }

  void updateSearchQuery(String query) {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(loadedState.copyWith(searchQuery: query));

      // Debounce search to avoid too many API calls
      _searchDebounceTimer?.cancel();
      _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
        print('[JOBS_CUBIT] Debounced search triggered for: $query');
        loadJobs();
      });
    }
  }

  void updateCardStyle(String style) {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(loadedState.copyWith(cardStyle: style));
    }
  }

  void setGridView() {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(loadedState.copyWith(isGridView: true));
    }
  }

  void setListView() {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(
        loadedState.copyWith(
          isGridView: false,
          cardStyle: 'minimal',
        ),
      );
    }
  }

  void clearJobs() {
    emit(
      const JobsState.loaded(),
    );
  }

  // Filter methods - now trigger job reload
  void updateLocationFilter(List<String> locations) {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(loadedState.copyWith(selectedLocations: locations));
      // Reload jobs with new filter
      loadJobs();
    }
  }

  void updateJobTypeFilter(List<String> jobTypes) {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(loadedState.copyWith(selectedJobTypes: jobTypes));
      // Reload jobs with new filter
      loadJobs();
    }
  }

  void updateExperienceLevelFilter(List<String> experienceLevels) {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(loadedState.copyWith(selectedExperienceLevels: experienceLevels));
      // Reload jobs with new filter
      loadJobs();
    }
  }

  void updateSalaryRange(int min, int max) {
    print('[JOBS_CUBIT] updateSalaryRange() called: $min - $max');
    if (state is JobsStateLoaded) {
      emit((state as JobsStateLoaded).copyWith(minSalary: min, maxSalary: max));
      loadJobs(page: 0);
    }
  }

  void clearFilters() {
    print('[JOBS_CUBIT] clearFilters() called');
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      emit(
        loadedState.copyWith(
          selectedLocations: [],
          selectedJobTypes: [],
          selectedExperienceLevels: [],
          searchQuery: '',
          minSalary: 0,
          maxSalary: 100000,
        ),
      );
      loadJobs(page: 0);
    }
  }

  // Save/Unsave methods
  Future<void> saveJob(String jobId) async {
    print('[JOBS_CUBIT] saveJob() called for jobId: $jobId');
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      final updatedSavedJobs = Set<String>.from(loadedState.savedJobs)
        ..add(jobId);
      emit(loadedState.copyWith(savedJobs: updatedSavedJobs));
    }

    // Call the SavedJobsRepository to save the job via API
    await _savedJobsRepository.saveJob(jobId);
  }

  Future<void> unsaveJob(String jobId) async {
    print('[JOBS_CUBIT] unsaveJob() called for jobId: $jobId');
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      final updatedSavedJobs = Set<String>.from(loadedState.savedJobs)
        ..remove(jobId);
      emit(loadedState.copyWith(savedJobs: updatedSavedJobs));
    }

    // Call the SavedJobsRepository to unsave the job via API
    await _savedJobsRepository.removeSavedJob(jobId);
  }

  Future<void> toggleSaveJob(String jobId) async {
    print('[JOBS_CUBIT] toggleSaveJob() called for jobId: $jobId');
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      if (loadedState.savedJobs.contains(jobId)) {
        await unsaveJob(jobId);
      } else {
        await saveJob(jobId);
      }
    }
  }

  void _updateJobsWithSavedStatus(Set<String> savedIds) {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      final updatedJobs = loadedState.jobs
          .map(
            (job) => job.copyWith(
              isSaved: savedIds.contains(job.id),
            ),
          )
          .toList();

      emit(loadedState.copyWith(jobs: updatedJobs));
    }
  }

  void updateAppliedJobIds(Set<String> appliedIds) {
    _appliedJobIds = appliedIds;
    _updateJobsWithAppliedStatus();
    _appliedJobsStorage.setAppliedJobIds(appliedIds);
  }

  void markJobAsApplied(String jobId) {
    if (_appliedJobIds.contains(jobId)) return;
    _appliedJobIds = {..._appliedJobIds, jobId};
    _updateJobsWithAppliedStatus();
    _appliedJobsStorage.addAppliedJobId(jobId);
  }

  void _updateJobsWithAppliedStatus() {
    if (state is JobsStateLoaded) {
      final loadedState = state as JobsStateLoaded;
      final updatedJobs = loadedState.jobs
          .map(
            (job) => job.copyWith(
              isApplied: _appliedJobIds.contains(job.id),
            ),
          )
          .toList();

      emit(loadedState.copyWith(jobs: updatedJobs));
    }
  }

  Future<void> _seedAppliedJobsFromCache() async {
    final cachedIds = await _appliedJobsStorage.getAppliedJobIds();
    if (cachedIds.isNotEmpty) {
      _appliedJobIds = cachedIds;
      _updateJobsWithAppliedStatus();
    }
  }
}

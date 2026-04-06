import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';
import 'package:tabashir/core/services/job_match_service.dart';
import 'package:tabashir/features/home/domain/repositories/home_repository.dart';
import 'home_state.dart';
import 'package:tabashir/core/utils/app_logger.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final JobMatchService _jobMatchService = getIt<JobMatchService>();
  final HomeRepository _homeRepository = getIt<HomeRepository>();
  bool _isDataLoaded = false;

  void updateLoading(bool isLoading) {
    if (isClosed) return;
    emit(state.copyWith(isLoading: isLoading));
  }

  void updateError(String message) {
    if (isClosed) return;
    emit(state.copyWith(error: true, errorMessage: message));
  }

  /// Refresh home data (pull to refresh)
  Future<void> refreshHomeData({
    CandidateProfileData? userProfile,
  }) async {
    AppLogger.debug('[HOME_CUBIT] Refreshing home data...', tag: 'Home');
    // Use email from state user if userProfile email not available
    final email = state.user?.email ?? '';
    await loadAiEnhancedHomeData(email: email);
  }

  /// Load new Native AI enhanced home screen data
  Future<void> loadAiEnhancedHomeData({
    required String email,
  }) async {
    AppLogger.debug('[HOME_CUBIT] Loading AI enhanced home data...', tag: 'Home');
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, error: false));

    try {
      // Load initial data (non-paginated)
      final results =
          await Future.wait([
            _homeRepository.getClientProfile(),
            _homeRepository.getAppliedJobsCount(email: email),
            _homeRepository.getMatchedJobs(email: email),
            _homeRepository.getJobsCountByCity(),
            _homeRepository.getLatestJobs(),
          ]).catchError((Object error) {
            AppLogger.error('[HOME_CUBIT] Error loading AI enhanced data: $error', tag: 'Home', error: error);
            // Return typed defaults if fetching fails
            return <Object>[
              <String, dynamic>{},
              0,
              <JobRecommendation>[],
              <CityJobCount>[],
              <Map<String, dynamic>>[],
            ];
          });

      final clientProfile = results[0] as Map<String, dynamic>? ?? {};
      final appliedJobsCount = results[1] as int? ?? 0;
      final matchedJobs = results[2] as List<JobRecommendation>? ?? [];
      final cityCounts = results[3] as List<CityJobCount>? ?? [];
      final latestJobs = results[4] as List<Map<String, dynamic>>? ?? [];

      AppLogger.debug('[HOME_CUBIT] === API Results Summary ===', tag: 'Home');
      AppLogger.debug('[HOME_CUBIT] Client Profile: ${clientProfile.isEmpty ? "empty" : "loaded"}', tag: 'Home');
      AppLogger.debug('[HOME_CUBIT] Applied Jobs Count: $appliedJobsCount', tag: 'Home');
      AppLogger.debug('[HOME_CUBIT] Matched Jobs: ${matchedJobs.length} jobs', tag: 'Home');
      if (matchedJobs.isNotEmpty) {
        for (var i = 0; i < matchedJobs.length; i++) {
          final job = matchedJobs[i];
          AppLogger.debug('[HOME_CUBIT] [$i] ${job.title} at ${job.company} - ${job.matchPercentage}% match', tag: 'Home');
        }
      } else {
        AppLogger.debug('[HOME_CUBIT] ⚠️ No matched jobs - user needs to upload resume', tag: 'Home');
      }
      AppLogger.debug('[HOME_CUBIT] City Counts: ${cityCounts.length} cities', tag: 'Home');
      AppLogger.debug('[HOME_CUBIT] Latest Jobs: ${latestJobs.length} jobs', tag: 'Home');

      // Process latest jobs using backend match percentages
      final processedLatestJobs = latestJobs.map((job) {
        try {
          final jobDetails = JobDetailsResponse.fromJson(job);
          final matchPercentage = _jobMatchService.formatMatchPercentage(
            jobDetails.matchPercentage,
          );
          return {
            ...job,
            'matchPercentage': matchPercentage,
          };
        } catch (e) {
          AppLogger.error('[HOME_CUBIT] Error processing match for job: $e', tag: 'Home', error: e);
          return {
            ...job,
            'matchPercentage': '50% Match',
          };
        }
      }).toList();

      // Load applied jobs separately with pagination
      var appliedJobs = <AppliedJob>[];
      try {
        appliedJobs = await _homeRepository.getAppliedJobs(
          email: email,
        );
        AppLogger.debug('[HOME_CUBIT] Applied Jobs List: ${appliedJobs.length} applications', tag: 'Home');
      } catch (e) {
        AppLogger.error('[HOME_CUBIT] Error loading applied jobs: $e', tag: 'Home', error: e);
      }

      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          clientProfile: clientProfile.isEmpty ? null : clientProfile,
          totalApplications: appliedJobsCount,
          matchedJobsList: matchedJobs,
          allMatchedJobsList: matchedJobs, // Initialize with first page
          matchedJobsPage: 1,
          matchedJobsTotal: matchedJobs.length,
          matchedJobsHasMore:
              matchedJobs.length == 10, // Assume has more if we got 10
          jobsToApplyNumber: clientProfile['jobs_to_apply_number'] as int? ?? 0,
          jobMatching: clientProfile['job_matching'] as int? ?? 0,
          cityJobCounts: cityCounts,
          latestJobsList: processedLatestJobs.isNotEmpty
              ? processedLatestJobs
              : latestJobs,
          appliedJobsList: appliedJobs,
          appliedJobsPage: 1,
          appliedJobsTotal: appliedJobs.length,
          appliedJobsHasMore:
              appliedJobs.length == 20, // Assume has more if we got 20
        ),
      );

      AppLogger.debug('[HOME_CUBIT] Successfully loaded AI enhanced home data', tag: 'Home');
    } catch (e) {
      AppLogger.error('[HOME_CUBIT] Error loading AI enhanced home data: $e', tag: 'Home', error: e);
      updateError('Failed to load AI enhanced home data: $e');
    }
  }

  /// Load all matched jobs (no limit) for the "All Matched Jobs" screen
  Future<void> loadAllMatchedJobs({
    required String email,
  }) async {
    AppLogger.debug('[HOME_CUBIT] Loading all matched jobs (no limit)...', tag: 'Home');
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, error: false));

    try {
      // Load with a high limit to get all matches
      final allMatchedJobs = await _homeRepository.getMatchedJobs(
        email: email,
        limit: 100,
      );

      AppLogger.debug('[HOME_CUBIT] Loaded ${allMatchedJobs.length} all matched jobs', tag: 'Home');
      if (allMatchedJobs.isNotEmpty) {
        for (var i = 0; i < allMatchedJobs.length; i++) {
          final job = allMatchedJobs[i];
          AppLogger.debug('[HOME_CUBIT] [$i] ${job.title} at ${job.company} - ${job.matchPercentage}% match', tag: 'Home');
        }
      }

      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          allMatchedJobsList: allMatchedJobs,
        ),
      );

      AppLogger.debug('[HOME_CUBIT] Successfully loaded all matched jobs', tag: 'Home');
    } catch (e) {
      AppLogger.error('[HOME_CUBIT] Error loading all matched jobs: $e', tag: 'Home', error: e);
      updateError('Failed to load all matched jobs: $e');
    }
  }

  /// Load applied jobs with pagination
  Future<void> loadAppliedJobs({
    required String email,
    int page = 1,
    int limit = 20,
  }) async {
    AppLogger.debug('[HOME_CUBIT] Loading applied jobs - Page: $page, Limit: $limit', tag: 'Home');
    if (isClosed) return;

    if (page == 1) {
      emit(state.copyWith(isLoading: true, isLoadingMoreApplied: false));
    } else {
      emit(state.copyWith(isLoadingMoreApplied: true));
    }

    try {
      final appliedJobs = await _homeRepository.getAppliedJobs(
        email: email,
        page: page,
        limit: limit,
      );

      AppLogger.debug('[HOME_CUBIT] Loaded ${appliedJobs.length} applied jobs', tag: 'Home');

      // Calculate if there are more jobs to load
      final hasMore = appliedJobs.length == limit;
      final totalCount = state.appliedJobsTotal;

      if (isClosed) return;

      if (page == 1) {
        // First page - replace list
        emit(
          state.copyWith(
            isLoading: false,
            appliedJobsList: appliedJobs,
            appliedJobsPage: page,
            appliedJobsTotal: totalCount,
            appliedJobsLimit: limit,
            appliedJobsHasMore: hasMore,
            isLoadingMoreApplied: false,
          ),
        );
      } else {
        // Subsequent page - append to list
        final updatedList = [...state.appliedJobsList, ...appliedJobs];
        emit(
          state.copyWith(
            appliedJobsList: updatedList,
            appliedJobsPage: page,
            appliedJobsTotal: totalCount,
            appliedJobsHasMore: hasMore,
            isLoadingMoreApplied: false,
          ),
        );
      }

      AppLogger.debug('[HOME_CUBIT] Successfully loaded applied jobs - Page: $page, HasMore: $hasMore', tag: 'Home');
    } catch (e) {
      AppLogger.error('[HOME_CUBIT] Error loading applied jobs: $e', tag: 'Home', error: e);
      if (page == 1) {
        emit(state.copyWith(isLoading: false, isLoadingMoreApplied: false));
      } else {
        emit(state.copyWith(isLoadingMoreApplied: false));
      }
      updateError('Failed to load applied jobs: $e');
    }
  }

  /// Load more applied jobs for pagination (appends to existing list)
  Future<void> loadMoreAppliedJobs() async {
    final currentState = state;
    final currentPage = currentState.appliedJobsPage;
    final hasMore = currentState.appliedJobsHasMore;
    final isLoadingMore = currentState.isLoadingMoreApplied;

    // Don't load more if already loading or no more data
    if (isLoadingMore || !hasMore) {
      AppLogger.debug('[HOME_CUBIT] loadMoreAppliedJobs() skipped - LoadingMore: $isLoadingMore, HasMore: $hasMore', tag: 'Home');
      return;
    }

    AppLogger.debug('[HOME_CUBIT] loadMoreAppliedJobs() called - Current page: $currentPage', tag: 'Home');

    // Load next page
    await loadAppliedJobs(
      email: currentState.user?.email ?? '',
      page: currentPage + 1,
      limit: currentState.appliedJobsLimit,
    );
  }

  /// Load more matched jobs for pagination (appends to existing list)
  Future<void> loadMoreMatchedJobs() async {
    final currentState = state;
    final currentPage = currentState.matchedJobsPage;
    final hasMore = currentState.matchedJobsHasMore;
    final isLoadingMore = currentState.isLoadingMoreMatched;

    // Don't load more if already loading or no more data
    if (isLoadingMore || !hasMore) {
      AppLogger.debug('[HOME_CUBIT] loadMoreMatchedJobs() skipped - LoadingMore: $isLoadingMore, HasMore: $hasMore', tag: 'Home');
      return;
    }

    AppLogger.debug('[HOME_CUBIT] loadMoreMatchedJobs() called - Current page: $currentPage', tag: 'Home');

    // Set loading state
    emit(state.copyWith(isLoadingMoreMatched: true));

    try {
      // Load next page
      final nextPage = currentPage + 1;
      final newMatchedJobs = await _homeRepository.getMatchedJobs(
        email: currentState.user?.email ?? '',
        limit: currentState.matchedJobsLimit,
      );

      AppLogger.debug('[HOME_CUBIT] Loaded ${newMatchedJobs.length} more matched jobs', tag: 'Home');

      if (isClosed) return;

      // Append to list
      final updatedList = [...state.matchedJobsList, ...newMatchedJobs];
      final hasMoreData =
          newMatchedJobs.length == currentState.matchedJobsLimit;

      emit(
        state.copyWith(
          matchedJobsList: updatedList,
          allMatchedJobsList: updatedList,
          matchedJobsPage: nextPage,
          matchedJobsHasMore: hasMoreData,
          isLoadingMoreMatched: false,
        ),
      );

      AppLogger.debug('[HOME_CUBIT] Successfully loaded more matched jobs - Page: $nextPage, HasMore: $hasMoreData', tag: 'Home');
    } catch (e) {
      AppLogger.error('[HOME_CUBIT] Error loading more matched jobs: $e', tag: 'Home', error: e);
      emit(state.copyWith(isLoadingMoreMatched: false));
      updateError('Failed to load more matched jobs: $e');
    }
  }

  /// Get a specific job by ID from the featured jobs list
  Map<String, dynamic>? getJobById(String jobId) {
    try {
      return state.jobs.firstWhere((job) => job['id']?.toString() == jobId);
    } catch (e) {
      return null;
    }
  }

  /// Update user data in home state
  void updateUserData(UserData userData) {
    if (isClosed) return;
    emit(state.copyWith(user: userData));
    AppLogger.debug('[HOME_CUBIT] User data updated: ${userData.name}', tag: 'Home');
  }

  /// Initialize HomeCubit with user profile data
  Future<void> initializeWithData({
    required UserProfileResponse userProfile,
  }) async {
    if (isClosed) return;

    AppLogger.debug('[HOME_CUBIT] Initializing with user profile for ${userProfile.user.name}', tag: 'Home');

    // Update user data first
    final userData = UserData(
      id: 'profile_${userProfile.user.name}',
      name: userProfile.user.name ?? '',
      email: userProfile.user.email ?? '',
      emailVerified: userProfile.user.emailVerified,
      image: userProfile.user.image,
      userType: userProfile.user.userType ?? 'CANDIDATE',
      adminRole: userProfile.user.adminRole,
      jobCount: userProfile.user.jobCount,
      aiJobApplyCount: userProfile.user.aiJobApplyCount,
      createdAt: userProfile.user.createdAt,
      updatedAt: userProfile.user.updatedAt,
      referralCode: userProfile.user.referralCode,
      referredBy: userProfile.user.referredBy,
    );

    emit(
      state.copyWith(
        isLoading: false,
        user: userData,
      ),
    );

    _isDataLoaded = true;

    // Load AI enhanced home data if email is available
    if (userProfile.user.email != null) {
      await loadAiEnhancedHomeData(email: userProfile.user.email!);
    }
  }

  /// Reset the cubit state (for logout/session change)
  void reset() {
    AppLogger.debug('[HOME_CUBIT] Resetting home data...', tag: 'Home');
    _isDataLoaded = false;
    if (!isClosed) {
      emit(const HomeState());
    }
  }
}

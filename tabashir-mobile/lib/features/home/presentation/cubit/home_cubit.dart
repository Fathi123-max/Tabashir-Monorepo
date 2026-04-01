import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';
import 'package:tabashir/core/services/job_match_service.dart';
import 'package:tabashir/features/home/domain/repositories/home_repository.dart';
import 'home_state.dart';

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
    print('[HOME_CUBIT] Refreshing home data...');
    // Use email from state user if userProfile email not available
    final email = state.user?.email ?? '';
    await loadAiEnhancedHomeData(email: email);
  }

  /// Load new Native AI enhanced home screen data
  Future<void> loadAiEnhancedHomeData({
    required String email,
  }) async {
    print('[HOME_CUBIT] Loading AI enhanced home data...');
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, error: false));

    try {
      // Load initial data (non-paginated)
      final results =
          await Future.wait([
            _homeRepository.getClientProfile(),
            _homeRepository.getAppliedJobsCount(email: email),
            _homeRepository.getMatchedJobs(email: email, limit: 10),
            _homeRepository.getJobsCountByCity(),
            _homeRepository.getLatestJobs(limit: 10),
          ]).catchError((Object error) {
            print('[HOME_CUBIT] Error loading AI enhanced data: $error');
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

      print('[HOME_CUBIT] === API Results Summary ===');
      print('[HOME_CUBIT] Client Profile: ${clientProfile.isEmpty ? "empty" : "loaded"}');
      print('[HOME_CUBIT] Applied Jobs Count: $appliedJobsCount');
      print('[HOME_CUBIT] Matched Jobs: ${matchedJobs.length} jobs');
      if (matchedJobs.isNotEmpty) {
        for (var i = 0; i < matchedJobs.length; i++) {
          final job = matchedJobs[i];
          print('[HOME_CUBIT]   [$i] ${job.title} at ${job.company} - ${job.matchPercentage}% match');
        }
      } else {
        print('[HOME_CUBIT]   ⚠️ No matched jobs - user needs to upload resume');
      }
      print('[HOME_CUBIT] City Counts: ${cityCounts.length} cities');
      print('[HOME_CUBIT] Latest Jobs: ${latestJobs.length} jobs');

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
          print('[HOME_CUBIT] Error processing match for job: $e');
          return {
            ...job,
            'matchPercentage': '50% Match',
          };
        }
      }).toList();

      // Load applied jobs separately with pagination
      List<AppliedJob> appliedJobs = [];
      try {
        appliedJobs = await _homeRepository.getAppliedJobs(
          email: email,
          page: 1,
          limit: 20,
        );
        print('[HOME_CUBIT] Applied Jobs List: ${appliedJobs.length} applications');
      } catch (e) {
        print('[HOME_CUBIT] Error loading applied jobs: $e');
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
          matchedJobsHasMore: matchedJobs.length == 10, // Assume has more if we got 10
          cityJobCounts: cityCounts,
          latestJobsList: processedLatestJobs.isNotEmpty
              ? processedLatestJobs
              : latestJobs,
          appliedJobsList: appliedJobs,
          appliedJobsPage: 1,
          appliedJobsTotal: appliedJobs.length,
          appliedJobsHasMore: appliedJobs.length == 20, // Assume has more if we got 20
        ),
      );

      print('[HOME_CUBIT] Successfully loaded AI enhanced home data');
    } catch (e) {
      print('[HOME_CUBIT] Error loading AI enhanced home data: $e');
      updateError('Failed to load AI enhanced home data: $e');
    }
  }

  /// Load all matched jobs (no limit) for the "All Matched Jobs" screen
  Future<void> loadAllMatchedJobs({
    required String email,
  }) async {
    print('[HOME_CUBIT] Loading all matched jobs (no limit)...');
    if (isClosed) return;
    emit(state.copyWith(isLoading: true, error: false));

    try {
      // Load with a high limit to get all matches
      final allMatchedJobs = await _homeRepository.getMatchedJobs(
        email: email,
        limit: 100,
      );

      print('[HOME_CUBIT] Loaded ${allMatchedJobs.length} all matched jobs');
      if (allMatchedJobs.isNotEmpty) {
        for (var i = 0; i < allMatchedJobs.length; i++) {
          final job = allMatchedJobs[i];
          print('[HOME_CUBIT]   [$i] ${job.title} at ${job.company} - ${job.matchPercentage}% match');
        }
      }

      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          allMatchedJobsList: allMatchedJobs,
        ),
      );

      print('[HOME_CUBIT] Successfully loaded all matched jobs');
    } catch (e) {
      print('[HOME_CUBIT] Error loading all matched jobs: $e');
      updateError('Failed to load all matched jobs: $e');
    }
  }

  /// Load applied jobs with pagination
  Future<void> loadAppliedJobs({
    required String email,
    int page = 1,
    int limit = 20,
  }) async {
    print('[HOME_CUBIT] Loading applied jobs - Page: $page, Limit: $limit');
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

      print('[HOME_CUBIT] Loaded ${appliedJobs.length} applied jobs');

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

      print('[HOME_CUBIT] Successfully loaded applied jobs - Page: $page, HasMore: $hasMore');
    } catch (e) {
      print('[HOME_CUBIT] Error loading applied jobs: $e');
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
    if (state is! HomeState) return;

    final currentState = state;
    final currentPage = currentState.appliedJobsPage;
    final hasMore = currentState.appliedJobsHasMore;
    final isLoadingMore = currentState.isLoadingMoreApplied;

    // Don't load more if already loading or no more data
    if (isLoadingMore || !hasMore) {
      print(
        '[HOME_CUBIT] loadMoreAppliedJobs() skipped - LoadingMore: $isLoadingMore, HasMore: $hasMore',
      );
      return;
    }

    print(
      '[HOME_CUBIT] loadMoreAppliedJobs() called - Current page: $currentPage',
    );

    // Load next page
    await loadAppliedJobs(
      email: currentState.user?.email ?? '',
      page: currentPage + 1,
      limit: currentState.appliedJobsLimit,
    );
  }

  /// Load more matched jobs for pagination (appends to existing list)
  Future<void> loadMoreMatchedJobs() async {
    if (state is! HomeState) return;

    final currentState = state;
    final currentPage = currentState.matchedJobsPage;
    final hasMore = currentState.matchedJobsHasMore;
    final isLoadingMore = currentState.isLoadingMoreMatched;

    // Don't load more if already loading or no more data
    if (isLoadingMore || !hasMore) {
      print(
        '[HOME_CUBIT] loadMoreMatchedJobs() skipped - LoadingMore: $isLoadingMore, HasMore: $hasMore',
      );
      return;
    }

    print(
      '[HOME_CUBIT] loadMoreMatchedJobs() called - Current page: $currentPage',
    );

    // Set loading state
    emit(state.copyWith(isLoadingMoreMatched: true));

    try {
      // Load next page
      final nextPage = currentPage + 1;
      final newMatchedJobs = await _homeRepository.getMatchedJobs(
        email: currentState.user?.email ?? '',
        limit: currentState.matchedJobsLimit,
      );

      print('[HOME_CUBIT] Loaded ${newMatchedJobs.length} more matched jobs');

      if (isClosed) return;

      // Append to list
      final updatedList = [...state.matchedJobsList, ...newMatchedJobs];
      final hasMoreData = newMatchedJobs.length == currentState.matchedJobsLimit;

      emit(
        state.copyWith(
          matchedJobsList: updatedList,
          allMatchedJobsList: updatedList,
          matchedJobsPage: nextPage,
          matchedJobsHasMore: hasMoreData,
          isLoadingMoreMatched: false,
        ),
      );

      print('[HOME_CUBIT] Successfully loaded more matched jobs - Page: $nextPage, HasMore: $hasMoreData');
    } catch (e) {
      print('[HOME_CUBIT] Error loading more matched jobs: $e');
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
    print('[HOME_CUBIT] User data updated: ${userData.name}');
  }

  /// Initialize HomeCubit with user profile data
  Future<void> initializeWithData({
    required UserProfileResponse userProfile,
  }) async {
    if (isClosed) return;

    print(
      '[HOME_CUBIT] Initializing with user profile for ${userProfile.user.name}',
    );

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
    print('[HOME_CUBIT] Resetting home data...');
    _isDataLoaded = false;
    if (!isClosed) {
      emit(const HomeState());
    }
  }
}

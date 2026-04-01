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
      final results =
          await Future.wait([
            _homeRepository.getClientProfile(),
            _homeRepository.getAppliedJobsCount(email: email),
            _homeRepository.getMatchedJobs(email: email, limit: 10),
            _homeRepository.getJobsCountByCity(),
            _homeRepository.getLatestJobs(limit: 10),
            _homeRepository.getAppliedJobs(email: email),
          ]).catchError((Object error) {
            print('[HOME_CUBIT] Error loading AI enhanced data: $error');
            // Return typed defaults if fetching fails
            return <Object>[
              <String, dynamic>{},
              0,
              <JobRecommendation>[],
              <CityJobCount>[],
              <Map<String, dynamic>>[],
              <AppliedJob>[],
            ];
          });

      final clientProfile = results[0] as Map<String, dynamic>? ?? {};
      final appliedJobsCount = results[1] as int? ?? 0;
      final matchedJobs = results[2] as List<JobRecommendation>? ?? [];
      final cityCounts = results[3] as List<CityJobCount>? ?? [];
      final latestJobs = results[4] as List<Map<String, dynamic>>? ?? [];
      final appliedJobs = results[5] as List<AppliedJob>? ?? [];

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
      print('[HOME_CUBIT] Applied Jobs List: ${appliedJobs.length} applications');

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

      if (isClosed) return;
      emit(
        state.copyWith(
          isLoading: false,
          clientProfile: clientProfile.isEmpty ? null : clientProfile,
          totalApplications: appliedJobsCount,
          matchedJobsList: matchedJobs,
          allMatchedJobsList: matchedJobs, // Also set for "All" screen (limited to 10)
          cityJobCounts: cityCounts,
          latestJobsList: processedLatestJobs.isNotEmpty
              ? processedLatestJobs
              : latestJobs,
          appliedJobsList: appliedJobs,
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

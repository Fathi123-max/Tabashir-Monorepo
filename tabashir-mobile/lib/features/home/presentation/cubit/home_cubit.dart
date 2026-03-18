import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/home_dashboard_response.dart';
import 'package:tabashir/core/services/job_match_service.dart';
import '../../services/home_api_service.dart';
import 'home_state.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeApiService) : super(const HomeState());

  final HomeApiService _homeApiService;
  final JobMatchService _jobMatchService = getIt<JobMatchService>();
  bool _isDataLoaded = false;

  void updateLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  void updateError(String message) {
    emit(state.copyWith(error: true, errorMessage: message));
  }

  Future<void> loadHomeData({
    CandidateProfileData? userProfile,
  }) async {
    // Prevent duplicate loads
    if (_isDataLoaded && state.jobs.isNotEmpty) {
      print('[HOME_CUBIT] Data already loaded, skipping duplicate load');
      return;
    }

    print('[HOME_CUBIT] Loading home data...');
    emit(state.copyWith(isLoading: true, error: false));

    try {
      // Load all data in parallel
      final results =
          await Future.wait([
            _homeApiService.getHomeDashboardData(),
            _homeApiService.getTrendingData().catchError((error) {
              print('[HOME_CUBIT] Trending data error: $error');
              return <String, dynamic>{
                'trendingText': 'Flutter and Node.js roles are up 17%',
                'growthPercentage': 17,
                'topSkills': ['JavaScript', 'React', 'Flutter'],
                'seeOpportunitiesLink': '/jobs',
              };
            }),
            _homeApiService.getMarketInsights().catchError((error) {
              print('[HOME_CUBIT] Market insights error: $error');
              return <String, dynamic>{
                'trendingSkills': [
                  {'skill': 'Flutter', 'growth': 23},
                  {'skill': 'React', 'growth': 18},
                  {'skill': 'Node.js', 'growth': 15},
                ],
                'topLocations': [
                  {'location': 'Dubai', 'count': 234},
                  {'location': 'Abu Dhabi', 'count': 156},
                  {'location': 'Sharjah', 'count': 89},
                ],
                'totalJobs': 1247,
                'newJobsThisWeek': 43,
              };
            }),
            _homeApiService.getAnalytics().catchError((error) {
              print('[HOME_CUBIT] Analytics error: $error');
              return <String, dynamic>{
                'applicationStatusChart': [
                  {'name': 'In Review', 'value': 5, 'color': '#FFA500'},
                  {'name': 'Interview', 'value': 3, 'color': '#0D56E1'},
                  {'name': 'Offer', 'value': 1, 'color': '#34D399'},
                ],
                'matchScoreDistribution': [
                  {'range': '90-100%', 'count': 3},
                  {'range': '80-89%', 'count': 8},
                  {'range': '70-79%', 'count': 11},
                ],
                'monthlyApplications': [
                  {'month': 'Jan', 'count': 2},
                  {'month': 'Feb', 'count': 4},
                  {'month': 'Mar', 'count': 3},
                ],
              };
            }),
            _homeApiService.getEnhancedRecommendations().catchError((error) {
              print('[HOME_CUBIT] Recommendations error: $error');
              return <String, dynamic>{
                'recommendedJobs': [],
                'reasons': ['Matches your skills', 'Based on your location'],
              };
            }),
          ]).catchError((error) {
            print('[HOME_CUBIT] Error loading parallel data: $error');
            // Return null for failed requests
            return [
              null,
              null,
              null,
              null,
              null,
            ];
          });

      final dashboardData = results[0] as HomeDashboardResponse?;
      final trendingData = results[1] as Map<String, dynamic>?;
      final marketInsights = results[2] as Map<String, dynamic>?;
      final analyticsData = results[3] as Map<String, dynamic>?;
      final recommendationsData = results[4] as Map<String, dynamic>?;

      // Process dashboard data
      if (dashboardData != null) {
        final featuredJobsForUI = dashboardData.featuredJobs.map(
          (job) {
            // Calculate match percentage using JobMatchService
            final matchPercentage = userProfile != null
                ? _jobMatchService.calculateMatchPercentage(
                    userProfile: userProfile,
                    job: job,
                  )
                : '50% Match'; // Default if no profile

            return {
              'id': job.jobId?.toString() ?? 'unknown',
              'title': job.jobTitle ?? 'Untitled Position',
              'company': job.companyName ?? 'Unknown Company',
              'location': job.location ?? 'Not specified',
              'employmentType': job.jobType ?? 'Full-time',
              'level': 'Not specified', // API doesn't provide this yet
              'matchPercentage': matchPercentage,
              'isBookmarked': false,
              'isPrimary': false,
            };
          },
        ).toList();

        // Emit the loaded state with all data
        emit(
          state.copyWith(
            isLoading: false,
            jobs: featuredJobsForUI,
            matches: dashboardData.totalMatches,
            companiesViewed: dashboardData.companiesViewed,
            matchDistribution: dashboardData.matchDistribution,
            inReview: dashboardData.inReview,
            interview: dashboardData.interviews,
            offer: dashboardData.offers,
            rejected: dashboardData.rejected,
            profileCompletionPercentage:
                dashboardData.profileCompletionPercentage,
            applicationSuccessRate: dashboardData.applicationSuccessRate,
            trendingData: trendingData,
            marketInsights: marketInsights,
            analyticsData: analyticsData,
            recommendationsData: recommendationsData,
          ),
        );

        // Mark data as loaded to prevent duplicate API calls
        _isDataLoaded = true;

        print('[HOME_CUBIT] Successfully loaded all home data');
      } else {
        updateError('Failed to load home data');
      }
    } catch (e) {
      print('[HOME_CUBIT] Error loading home data: $e');
      updateError('Failed to load home data: $e');
    }
  }

  /// Refresh home data (pull to refresh)
  Future<void> refreshHomeData({
    CandidateProfileData? userProfile,
  }) async {
    print('[HOME_CUBIT] Refreshing home data...');
    await loadHomeData(userProfile: userProfile);
  }

  /// Get a specific job by ID from the featured jobs list
  Map<String, dynamic>? getJobById(String jobId) {
    try {
      return state.jobs.firstWhere((job) => job['id'] == jobId);
    } catch (e) {
      return null;
    }
  }

  /// Update user data in home state
  void updateUserData(UserData userData) {
    emit(state.copyWith(user: userData));
    print('[HOME_CUBIT] User data updated: ${userData.name}');
  }

  /// Load trending data from API
  Future<Map<String, dynamic>> loadTrendingData() async {
    print('[HOME_CUBIT] Loading trending data...');
    try {
      final data = await _homeApiService.getTrendingData();
      print('[HOME_CUBIT] Trending data loaded successfully');
      return data;
    } catch (e) {
      print('[HOME_CUBIT] Error loading trending data: $e');
      rethrow;
    }
  }

  /// Load market insights data from API
  Future<Map<String, dynamic>> loadMarketInsights() async {
    print('[HOME_CUBIT] Loading market insights...');
    try {
      final data = await _homeApiService.getMarketInsights();
      print('[HOME_CUBIT] Market insights loaded successfully');
      return data;
    } catch (e) {
      print('[HOME_CUBIT] Error loading market insights: $e');
      rethrow;
    }
  }

  /// Load analytics data from API
  Future<Map<String, dynamic>> loadAnalytics() async {
    print('[HOME_CUBIT] Loading analytics data...');
    try {
      final data = await _homeApiService.getAnalytics();
      print('[HOME_CUBIT] Analytics data loaded successfully');
      return data;
    } catch (e) {
      print('[HOME_CUBIT] Error loading analytics: $e');
      rethrow;
    }
  }

  /// Load enhanced recommendations from API
  Future<Map<String, dynamic>> loadEnhancedRecommendations() async {
    print('[HOME_CUBIT] Loading enhanced recommendations...');
    try {
      final data = await _homeApiService.getEnhancedRecommendations();
      print('[HOME_CUBIT] Enhanced recommendations loaded successfully');
      return data;
    } catch (e) {
      print('[HOME_CUBIT] Error loading enhanced recommendations: $e');
      rethrow;
    }
  }

  /// Load comprehensive dashboard data from API
  Future<Map<String, dynamic>> loadDashboardData() async {
    print('[HOME_CUBIT] Loading dashboard data...');
    try {
      final data = await _homeApiService.getDashboardData();
      print('[HOME_CUBIT] Dashboard data loaded successfully');
      return data;
    } catch (e) {
      print('[HOME_CUBIT] Error loading dashboard data: $e');
      rethrow;
    }
  }

  /// Load all home data including new features
  Future<void> loadAllHomeData({
    CandidateProfileData? userProfile,
  }) async {
    // Prevent duplicate loads
    if (_isDataLoaded && state.jobs.isNotEmpty) {
      print('[HOME_CUBIT] Data already loaded, skipping duplicate load');
      return;
    }

    print('[HOME_CUBIT] Loading all home data...');
    emit(state.copyWith(isLoading: true, error: false));

    try {
      // Load all data in parallel
      final results =
          await Future.wait([
            _homeApiService.getHomeDashboardData(),
            _homeApiService.getTrendingData(),
            _homeApiService.getMarketInsights(),
            _homeApiService.getAnalytics(),
            _homeApiService.getEnhancedRecommendations(),
            _homeApiService.getDashboardData(),
          ]).catchError((error) {
            print('[HOME_CUBIT] Error loading parallel data: $error');
            // Return empty maps for failed requests
            return [
              null, // getHomeDashboardData
              null, // getTrendingData
              null, // getMarketInsights
              null, // getAnalytics
              null, // getEnhancedRecommendations
              null, // getDashboardData
            ];
          });

      final dashboardData = results[0] as HomeDashboardResponse?;
      final trendingData = results[1] as Map<String, dynamic>?;
      final marketInsights = results[2] as Map<String, dynamic>?;
      final analyticsData = results[3] as Map<String, dynamic>?;
      final recommendationsData = results[4] as Map<String, dynamic>?;
      final dashboardDataNew = results[5] as Map<String, dynamic>?;

      // Process dashboard data
      if (dashboardData != null) {
        final featuredJobsForUI = dashboardData.featuredJobs.map(
          (job) {
            final matchPercentage = userProfile != null
                ? _jobMatchService.calculateMatchPercentage(
                    userProfile: userProfile,
                    job: job,
                  )
                : '50% Match';

            return {
              'id': job.jobId?.toString() ?? 'unknown',
              'title': job.jobTitle ?? 'Untitled Position',
              'company': job.companyName ?? 'Unknown Company',
              'location': job.location ?? 'Not specified',
              'employmentType': job.jobType ?? 'Full-time',
              'level': 'Not specified',
              'matchPercentage': matchPercentage,
              'isBookmarked': false,
              'isPrimary': false,
            };
          },
        ).toList();

        emit(
          state.copyWith(
            isLoading: false,
            jobs: featuredJobsForUI,
            matches: dashboardData.totalMatches,
            companiesViewed: dashboardData.companiesViewed,
            matchDistribution: dashboardData.matchDistribution,
            inReview: dashboardData.inReview,
            interview: dashboardData.interviews,
            offer: dashboardData.offers,
            rejected: dashboardData.rejected,
            trendingData: trendingData,
            marketInsights: marketInsights,
            analyticsData: analyticsData,
            recommendationsData: recommendationsData,
            dashboardData: dashboardDataNew,
          ),
        );

        print('[HOME_CUBIT] Successfully loaded all home data');
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: true,
            errorMessage: 'Failed to load data',
          ),
        );
      }
    } catch (e) {
      print('[HOME_CUBIT] Error loading all home data: $e');
      updateError('Failed to load home data: $e');
    }
  }
}

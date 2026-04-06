import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/_clients/auth_dio_client.dart';
import 'package:tabashir/core/network/models/home_dashboard_response.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';
import 'package:tabashir/core/network/services/job/tabashir_api_service.dart';
import 'package:tabashir/core/network/services/user/user_api_service.dart';
import 'package:tabashir/core/services/local_storage_service.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Service for fetching home dashboard data
@injectable
class HomeApiService {
  HomeApiService(
    this._tabashirApiService,
    this._userApiService,
    this._authDioClient,
    this._localStorageService,
  );

  final TabashirApiService _tabashirApiService;
  final UserApiService _userApiService;
  final AuthDioClient _authDioClient;
  final LocalStorageService _localStorageService;

  static const String _homeBaseUrl = '/api/v1/home';

  /// Fetch home dashboard data including featured jobs and user statistics
  Future<HomeDashboardResponse> getHomeDashboardData({
    int featuredJobsLimit = 3,
    String? email,
  }) async {
    AppLogger.debug('[HOME_API_SERVICE] Fetching home dashboard data for email: $email', tag: 'Home');

    try {
      // Fetch data from the new dashboard API endpoint
      final response = await _authDioClient.dio.get(
        '$_homeBaseUrl/dashboard',
      );

      final responseData = response.data as Map<String, dynamic>;

      AppLogger.debug('[HOME_API_SERVICE] Fetched dashboard data: $responseData', tag: 'Home');

      // Extract stats and metrics from response
      final metrics = responseData['metrics'] as Map<String, dynamic>? ?? {};
      final profileCompletionPercentage =
          metrics['profileCompletionPercentage'] as int? ?? 0;
      final applicationSuccessRate =
          metrics['applicationSuccessRate'] as int? ?? 0;

      final statsMap = responseData['stats'] as Map<String, dynamic>? ?? {};
      final totalMatches = statsMap['totalMatches'] as int? ?? 0;
      final avgMarketSalary = statsMap['avgMarketSalary'] as String? ?? 'N/A';
      final totalApplications = statsMap['totalApplications'] as int? ?? 0;
      final inReview = statsMap['inReview'] as int? ?? 0;
      final interviews = statsMap['interviews'] as int? ?? 0;
      final offers = statsMap['offers'] as int? ?? 0;
      final rejected = statsMap['rejected'] as int? ?? 0;

      // Extract featured jobs from the response or fetch separately
      final featuredJobsData =
          responseData['featuredJobs'] as List<dynamic>? ?? [];
      final featuredJobs = featuredJobsData
          .map(
            (job) => JobDetailsResponse.fromJson(job as Map<String, dynamic>),
          )
          .toList();

      // If no featured jobs in response, fetch from jobs API
      var finalFeaturedJobs = featuredJobs;
      if (featuredJobs.isEmpty) {
        final jobsResponse = await _tabashirApiService.getJobs(
          page: 0,
          limit: featuredJobsLimit,
          email: email,
        );
        final allJobs = jobsResponse.data.jobs ?? <JobDetailsResponse>[];
        finalFeaturedJobs = allJobs.take(featuredJobsLimit).toList();
      }

      AppLogger.debug('[HOME_API_SERVICE] Fetched ${finalFeaturedJobs.length} featured jobs', tag: 'Home');

      // Format match distribution as "inReview | interviews | offers"
      final matchDistribution = '$inReview | $interviews | $offers';

      AppLogger.debug('[HOME_API_SERVICE] Statistics - Matches: $totalMatches, Salary: $avgMarketSalary, In Review: $inReview, Interviews: $interviews, Offers: $offers', tag: 'Home');

      return HomeDashboardResponse(
        featuredJobs: finalFeaturedJobs,
        totalMatches: totalMatches,
        avgMarketSalary: avgMarketSalary,
        totalApplications: totalApplications,
        companiesViewed: 0, // No longer used in stats but required by model
        inReview: inReview,
        interviews: interviews,
        offers: offers,
        rejected: rejected,
        matchDistribution: matchDistribution,
        profileCompletionPercentage: profileCompletionPercentage,
        applicationSuccessRate: applicationSuccessRate,
      );
    } catch (e) {
      AppLogger.error('[HOME_API_SERVICE] Error: $e', tag: 'Home', error: e);
      rethrow;
    }
  }

  /// Get enhanced job recommendations
  Future<Map<String, dynamic>> getEnhancedRecommendations() async {
    AppLogger.debug('[HOME_API_SERVICE] Fetching enhanced recommendations', tag: 'Home');

    try {
      final response = await _authDioClient.dio.get(
        '$_homeBaseUrl/recommendations',
      );

      AppLogger.debug('[HOME_API_SERVICE] Fetched recommendations: ${response.data}', tag: 'Home');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      AppLogger.error('[HOME_API_SERVICE] Error fetching recommendations: $e', tag: 'Home', error: e);
      rethrow;
    }
  }

  /// Check if job is in review status
  /// This depends on the actual API response structure
  bool _isInReview(dynamic job) {
    // TODO: Implement based on actual API response structure
    // For now, assume some jobs are in review
    return false;
  }

  /// Check if job has interview status
  bool _isInterview(dynamic job) {
    // TODO: Implement based on actual API response structure
    return false;
  }

  /// Check if job has offer status
  bool _isOffer(dynamic job) {
    // TODO: Implement based on actual API response structure
    return false;
  }

  /// Check if job is rejected
  bool _isRejected(dynamic job) {
    // TODO: Implement based on actual API response structure
    return false;
  }
}

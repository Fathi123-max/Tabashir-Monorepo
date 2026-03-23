import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/_clients/auth_dio_client.dart';
import 'package:tabashir/core/network/models/home_dashboard_response.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';
import 'package:tabashir/core/network/services/job/tabashir_api_service.dart';
import 'package:tabashir/core/network/services/user/user_api_service.dart';
import 'package:tabashir/core/services/local_storage_service.dart';

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

  static const String _homeBaseUrl = '/v1/home';

  /// Fetch home dashboard data including featured jobs and user statistics
  Future<HomeDashboardResponse> getHomeDashboardData({
    int featuredJobsLimit = 3,
  }) async {
    print('[HOME_API_SERVICE] Fetching home dashboard data');

    try {
      // Fetch data from the new dashboard API endpoint
      final response = await _authDioClient.dio.get(
        '$_homeBaseUrl/dashboard',
      );

      final responseData = response.data as Map<String, dynamic>;

      print('[HOME_API_SERVICE] Fetched dashboard data: $responseData');

      // Extract stats from response
      final stats = responseData['stats'] as Map<String, dynamic>? ?? {};
      final metrics = responseData['metrics'] as Map<String, dynamic>? ?? {};

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
        );
        final allJobs = jobsResponse.data.jobs ?? <JobDetailsResponse>[];
        finalFeaturedJobs = allJobs.take(featuredJobsLimit).toList();
      }

      print(
        '[HOME_API_SERVICE] Fetched ${finalFeaturedJobs.length} featured jobs',
      );

      // Extract metrics with defaults
      final profileCompletionPercentage =
          metrics['profileCompletionPercentage'] as int? ?? 0;
      final applicationSuccessRate =
          metrics['applicationSuccessRate'] as int? ?? 0;

      final stats = data['stats'] as Map<String, dynamic>? ?? {};
      final totalMatches = stats['totalMatches'] as int? ?? 0;
      final avgMarketSalary = stats['avgMarketSalary'] as String? ?? 'N/A';
      final totalApplications = stats['totalApplications'] as int? ?? 0;
      final inReview = stats['inReview'] as int? ?? 0;
      final interviews = stats['interviews'] as int? ?? 0;
      final offers = stats['offers'] as int? ?? 0;
      final rejected = stats['rejected'] as int? ?? 0;

      // Format match distribution as "inReview | interviews | offers"
      final matchDistribution = '$inReview | $interviews | $offers';

      print(
        '[HOME_API_SERVICE] Statistics - Matches: $totalMatches, Salary: $avgMarketSalary, In Review: $inReview, Interviews: $interviews, Offers: $offers',
      );

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
      print('[HOME_API_SERVICE] Error: $e');
      rethrow;
    }
  }

  /// Get trending data for the home screen
  Future<Map<String, dynamic>> getTrendingData() async {
    print('[HOME_API_SERVICE] Fetching trending data');

    try {
      final response = await _authDioClient.dio.get(
        '$_homeBaseUrl/trending',
      );

      print('[HOME_API_SERVICE] Fetched trending data: ${response.data}');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('[HOME_API_SERVICE] Error fetching trending data: $e');
      rethrow;
    }
  }

  /// Get market insights data
  Future<Map<String, dynamic>> getMarketInsights() async {
    print('[HOME_API_SERVICE] Fetching market insights');

    try {
      final response = await _authDioClient.dio.get(
        '$_homeBaseUrl/market-insights',
      );

      print('[HOME_API_SERVICE] Fetched market insights: ${response.data}');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('[HOME_API_SERVICE] Error fetching market insights: $e');
      rethrow;
    }
  }

  /// Get analytics data for charts
  Future<Map<String, dynamic>> getAnalytics() async {
    print('[HOME_API_SERVICE] Fetching analytics data');

    try {
      final response = await _authDioClient.dio.get(
        '$_homeBaseUrl/analytics',
      );

      print('[HOME_API_SERVICE] Fetched analytics: ${response.data}');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('[HOME_API_SERVICE] Error fetching analytics: $e');
      rethrow;
    }
  }

  /// Get enhanced job recommendations
  Future<Map<String, dynamic>> getEnhancedRecommendations() async {
    print('[HOME_API_SERVICE] Fetching enhanced recommendations');

    try {
      final response = await _authDioClient.dio.get(
        '$_homeBaseUrl/recommendations',
      );

      print('[HOME_API_SERVICE] Fetched recommendations: ${response.data}');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('[HOME_API_SERVICE] Error fetching recommendations: $e');
      rethrow;
    }
  }

  /// Get comprehensive dashboard data
  Future<Map<String, dynamic>> getDashboardData() async {
    print('[HOME_API_SERVICE] Fetching dashboard data');

    try {
      final response = await _authDioClient.dio.get(
        '$_homeBaseUrl/dashboard',
      );

      print('[HOME_API_SERVICE] Fetched dashboard: ${response.data}');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      print('[HOME_API_SERVICE] Error fetching dashboard: $e');
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

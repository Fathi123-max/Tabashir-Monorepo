import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';

part 'home_dashboard_response.freezed.dart';
part 'home_dashboard_response.g.dart';

/// Response model for home dashboard data
@freezed
sealed class HomeDashboardResponse with _$HomeDashboardResponse {
  const factory HomeDashboardResponse({
    /// List of featured jobs to display on home screen
    required List<JobDetailsResponse> featuredJobs,

    /// Total number of job matches
    required int totalMatches,

    /// Total number of companies the user has viewed
    required int companiesViewed,

    /// Number of applications currently in review
    required int inReview,

    /// Number of interviews scheduled
    required int interviews,

    /// Number of job offers received
    required int offers,

    /// Number of applications rejected
    required int rejected,

    /// Distribution of matches (format: "active | interviewing | offered")
    required String matchDistribution,

    /// Profile completion percentage (0-100)
    required int profileCompletionPercentage,

    /// Application success rate percentage (0-100)
    required int applicationSuccessRate,

    /// Average market salary for user's role
    String? avgMarketSalary,

    /// Total number of applications
    int? totalApplications,

    /// Job counts by city for location-based statistics
    Map<String, int>? jobsByCity,

    /// Monthly job counts for trends
    Map<String, int>? monthlyJobCounts,
  }) = _HomeDashboardResponse;

  factory HomeDashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDashboardResponseFromJson(json);
}

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/isar_service.dart';
import 'package:tabashir/features/home/domain/repositories/home_repository.dart';

/// Implementation of [HomeRepository]
/// Handles home dashboard operations using [IsarService] for local storage
@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._isarService);

  final IsarService _isarService;

  @override
  Future<DashboardData> getDashboardData({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final dashboardJson = prefs.getString('dashboard_data_$userId');
      if (dashboardJson == null || dashboardJson.isEmpty) {
        // Return default dashboard data
        return DashboardData(
          userId: userId,
          userName: 'User',
          userEmail: '',
        );
      }

      final dashboard = jsonDecode(dashboardJson) as Map<String, dynamic>;
      return DashboardData.fromJson(dashboard);
    } catch (e) {
      throw Exception('Failed to get dashboard data: $e');
    }
  }

  @override
  Future<List<QuickAction>> getQuickActions({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final actionsJson = prefs.getString('quick_actions_$userId');
      if (actionsJson == null || actionsJson.isEmpty) {
        // Return default quick actions
        return const [
          QuickAction(
            id: 'browse_jobs',
            title: 'Browse Jobs',
            icon: 'search',
            route: '/jobs',
          ),
          QuickAction(
            id: 'my_applications',
            title: 'My Applications',
            icon: 'description',
            route: '/applications',
          ),
          QuickAction(
            id: 'saved_jobs',
            title: 'Saved Jobs',
            icon: 'bookmark',
            route: '/saved-jobs',
          ),
          QuickAction(
            id: 'profile',
            title: 'My Profile',
            icon: 'person',
            route: '/profile',
          ),
        ];
      }

      final actionsList = jsonDecode(actionsJson) as List<dynamic>;
      return actionsList
          .map((json) => QuickAction.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get quick actions: $e');
    }
  }

  @override
  Future<List<RecentActivity>> getRecentActivities({
    required String userId,
    int limit = 10,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final activitiesJson = prefs.getString('recent_activities_$userId');
      if (activitiesJson == null || activitiesJson.isEmpty) {
        return <RecentActivity>[];
      }

      final activitiesList = jsonDecode(activitiesJson) as List<dynamic>;
      var activities = activitiesList
          .map((json) => RecentActivity.fromJson(json as Map<String, dynamic>))
          .toList();

      // Sort by timestamp (newest first)
      activities.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      // Apply limit
      if (activities.length > limit) {
        activities = activities.take(limit).toList();
      }

      return activities;
    } catch (e) {
      throw Exception('Failed to get recent activities: $e');
    }
  }

  @override
  Future<List<JobRecommendation>> getJobRecommendations({
    required String userId,
    int limit = 5,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final recommendationsJson = prefs.getString(
        'job_recommendations_$userId',
      );
      if (recommendationsJson == null || recommendationsJson.isEmpty) {
        return <JobRecommendation>[];
      }

      final recommendationsList =
          jsonDecode(recommendationsJson) as List<dynamic>;
      var recommendations = recommendationsList
          .map(
            (json) => JobRecommendation.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      // Sort by match percentage (highest first)
      recommendations.sort(
        (a, b) => b.matchPercentage.compareTo(a.matchPercentage),
      );

      // Apply limit
      if (recommendations.length > limit) {
        recommendations = recommendations.take(limit).toList();
      }

      return recommendations;
    } catch (e) {
      throw Exception('Failed to get job recommendations: $e');
    }
  }

  @override
  Future<void> saveActivity({
    required String userId,
    required RecentActivity activity,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final activitiesJson = prefs.getString('recent_activities_$userId');
      final activities = <RecentActivity>[];

      if (activitiesJson != null && activitiesJson.isNotEmpty) {
        final activitiesList = jsonDecode(activitiesJson) as List<dynamic>;
        activities.addAll(
          activitiesList.map(
            (json) => RecentActivity.fromJson(json as Map<String, dynamic>),
          ),
        );
      }

      // Add new activity at the beginning
      activities.insert(0, activity);

      // Keep only the latest 50 activities
      if (activities.length > 50) {
        final limitedActivities = activities.take(50).toList();
        activities
          ..clear()
          ..addAll(limitedActivities);
      }

      final updatedJson = jsonEncode(
        activities.map((a) => a.toJson()).toList(),
      );
      await prefs.setString('recent_activities_$userId', updatedJson);
    } catch (e) {
      throw Exception('Failed to save activity: $e');
    }
  }

  @override
  Future<void> clearActivities({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      await prefs.remove('recent_activities_$userId');
    } catch (e) {
      throw Exception('Failed to clear activities: $e');
    }
  }

  @override
  Future<void> updateUserStats({
    required String userId,
    int? totalApplications,
    int? savedJobs,
    int? profileViews,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final dashboardJson = prefs.getString('dashboard_data_$userId');

      if (dashboardJson == null || dashboardJson.isEmpty) {
        return;
      }

      final dashboard = jsonDecode(dashboardJson) as Map<String, dynamic>;

      if (totalApplications != null) {
        dashboard['totalApplications'] = totalApplications;
      }
      if (savedJobs != null) {
        dashboard['savedJobs'] = savedJobs;
      }
      if (profileViews != null) {
        dashboard['profileViews'] = profileViews;
      }

      final updatedJson = jsonEncode(dashboard);
      await prefs.setString('dashboard_data_$userId', updatedJson);
    } catch (e) {
      throw Exception('Failed to update user stats: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> searchJobs({
    required String query,
    String? location,
    String? category,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final jobsJson = prefs.getString('all_jobs_list');
      if (jobsJson == null || jobsJson.isEmpty) {
        return <Map<String, dynamic>>[];
      }

      final jobsList = jsonDecode(jobsJson) as List<dynamic>;
      var jobs = jobsList.cast<Map<String, dynamic>>();

      // Filter by query
      final lowerQuery = query.toLowerCase();
      jobs = jobs.where((job) {
        final title = (job['title'] ?? '').toString().toLowerCase();
        final company = (job['company'] ?? '').toString().toLowerCase();
        final desc = (job['description'] ?? '').toString().toLowerCase();

        return title.contains(lowerQuery) ||
            company.contains(lowerQuery) ||
            desc.contains(lowerQuery);
      }).toList();

      // Filter by location if provided
      if (location != null && location.isNotEmpty) {
        final lowerLocation = location.toLowerCase();
        jobs = jobs.where((job) {
          final jobLocation = (job['location'] ?? '').toString().toLowerCase();
          return jobLocation.contains(lowerLocation);
        }).toList();
      }

      // Filter by category if provided
      if (category != null && category.isNotEmpty) {
        jobs = jobs.where((job) => job['category'] == category).toList();
      }

      // Apply pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      if (startIndex >= jobs.length) {
        return <Map<String, dynamic>>[];
      }

      return jobs.sublist(
        startIndex,
        endIndex.clamp(0, jobs.length),
      );
    } catch (e) {
      throw Exception('Failed to search jobs: $e');
    }
  }
}

import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/services/local_persistence_service.dart';
import 'package:tabashir/features/home/domain/repositories/home_repository.dart';
import 'package:tabashir/core/network/services/job/tabashir_api_service.dart';
import 'package:tabashir/core/network/models/email_model.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Implementation of [HomeRepository]
/// Handles home dashboard operations using [LocalPersistenceService] for local storage
@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._persistenceService, this._tabashirApiService);

  final LocalPersistenceService _persistenceService;
  final TabashirApiService _tabashirApiService;

  @override
  Future<DashboardData> getDashboardData({
    required String userId,
  }) async {
    try {
      final prefs = _persistenceService.prefs;
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
      final prefs = _persistenceService.prefs;
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
      final prefs = _persistenceService.prefs;
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
      final prefs = _persistenceService.prefs;
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
      final prefs = _persistenceService.prefs;
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
      final prefs = _persistenceService.prefs;
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
      final prefs = _persistenceService.prefs;
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
      final prefs = _persistenceService.prefs;
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

  @override
  Future<Map<String, dynamic>> getClientProfile() async {
    try {
      final response = await _tabashirApiService.getClient();
      final aiClientData = response.data.data;
      if (aiClientData != null) {
        return {
          'nationality': aiClientData.nationality,
          'gender': aiClientData.gender,
          'location': aiClientData.location,
          'positions': aiClientData.positions,
          'filename': aiClientData.filename,
          'jobs_to_apply_number': aiClientData.jobsToApplyNumber,
          'job_matching': aiClientData.jobMatching,
        };
      }
      return {};
    } catch (e) {
      AppLogger.error('Error getting client profile: $e', tag: 'Home', error: e);
      return {};
    }
  }

  @override
  Future<int> getAppliedJobsCount({required String email}) async {
    try {
      final response = await _tabashirApiService.getAppliedJobsCount(
        EmailModel(email: email),
      );
      return response.data.appliedJobsCount;
    } catch (e) {
      AppLogger.error('Error getting applied jobs count: $e', tag: 'Home', error: e);
      return 0;
    }
  }

  @override
  Future<List<JobRecommendation>> getMatchedJobs({
    required String email,
    int page = 1,
    int limit = 10,
    String? lang,
  }) async {
    try {
      AppLogger.debug('[HOME_REPO] Fetching matched jobs for email: $email', tag: 'Home');
      AppLogger.debug('[HOME_REPO] API params: email=$email, limit=$limit, page=$page, lang=$lang', tag: 'Home');

      final response = await _tabashirApiService.getJobMatches(email, limit, page, lang);
      final jobs = response.data.matchedJobs;

      AppLogger.debug('[HOME_REPO] API response received', tag: 'Home');
      AppLogger.debug('[HOME_REPO] Matched jobs count: ${jobs.length}', tag: 'Home');

      if (jobs.isEmpty) {
        AppLogger.debug('[HOME_REPO] WARNING: No matched jobs returned from API', tag: 'Home');
        AppLogger.debug('[HOME_REPO] This means the backend rankings table has no entries for this user', tag: 'Home');
        AppLogger.debug('[HOME_REPO] User needs to upload resume for AI matching', tag: 'Home');
      } else {
        AppLogger.debug('[HOME_REPO] Jobs returned:', tag: 'Home');
        for (var i = 0; i < jobs.length; i++) {
          final job = jobs[i];
          AppLogger.debug('[HOME_REPO] [$i] JobID: ${job.jobId}, Title: ${job.jobTitle}, Match: ${job.matchPercentage}', tag: 'Home');
        }
      }

      final result = jobs.map((job) {
        final matchPctRaw = job.matchPercentage;
        int matchPct;
        if (matchPctRaw == null || matchPctRaw.isEmpty) {
          matchPct = 0;
        } else {
          final cleaned = matchPctRaw.replaceAll(RegExp('[^0-9]'), '');
          matchPct = cleaned.isEmpty ? 0 : int.parse(cleaned);
        }
        // Use jobId from either 'id' or 'job_id' field
        final jobId = job.jobId ?? job.rankingsJobId ?? '';

        // Build tags from job_type and languages
        final tags = <String>[];
        if (job.jobType != null && job.jobType!.isNotEmpty) {
          tags.add(job.jobType!);
        }
        if (job.languages != null && job.languages!.isNotEmpty) {
          // Split languages by comma and take first 2
          final langList = job.languages!.split(',').take(2).toList();
          tags.addAll(langList.map((l) => l.trim()));
        }

        // Use salary from API or null (widget will handle display)
        final salary = job.salary;

        return JobRecommendation(
          id: jobId,
          title: job.jobTitle ?? 'Unknown Title',
          company: job.companyName ?? 'Unknown Company',
          location: job.location ?? 'Remote',
          matchPercentage: matchPct,
          salary: salary,
          jobType: job.jobType,
          languages: job.languages,
          experience: job.experience,
        );
      }).toList();

      AppLogger.debug('[HOME_REPO] Processed ${result.length} JobRecommendation objects', tag: 'Home');
      return result;
    } catch (e, stackTrace) {
      AppLogger.debug('[HOME_REPO] ERROR getting matched jobs: $e', tag: 'Home');
      AppLogger.debug('[HOME_REPO] Stack trace: $stackTrace', tag: 'Home');
      return [];
    }
  }

  @override
  Future<List<CityJobCount>> getJobsCountByCity() async {
    try {
      final response = await _tabashirApiService.getJobsCountByCity('');
      final counts = response.data.data;
      return counts
          .map(
            (c) => CityJobCount(
              city: c.vacancyCity,
              count: c.count,
            ),
          )
          .toList();
    } catch (e) {
      AppLogger.error('Error getting city counts: $e', tag: 'Home', error: e);
      return [];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getLatestJobs({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final response = await _tabashirApiService.getJobs(
        page: page,
        limit: limit,
      );
      final jobs = response.data.jobs ?? [];
      return jobs.map((j) => j.toJson()).toList();
    } catch (e) {
      AppLogger.error('Error getting latest jobs: $e', tag: 'Home', error: e);
      return [];
    }
  }

  @override
  Future<List<AppliedJob>> getAppliedJobs({
    required String email,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      AppLogger.debug('[HOME_REPO] Fetching applied jobs for email: $email', tag: 'Home');
      AppLogger.debug('[HOME_REPO] Pagination params - Page: $page, Limit: $limit', tag: 'Home');

      final response = await _tabashirApiService.getAppliedJobs(
        email,
        page: page,
        limit: limit,
      );

      AppLogger.debug('[HOME_REPO] Applied jobs response: ${response.data.jobs.length} jobs', tag: 'Home');
      return response.data.jobs;
    } catch (e) {
      AppLogger.error('Error getting applied jobs: $e', tag: 'Home', error: e);
      return [];
    }
  }
}

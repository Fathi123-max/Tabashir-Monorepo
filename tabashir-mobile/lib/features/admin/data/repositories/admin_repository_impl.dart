import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/isar_service.dart';
import 'package:tabashir/features/admin/domain/repositories/admin_repository.dart';

/// Implementation of [AdminRepository]
/// Handles admin operations using [IsarService] for local storage
@Injectable(as: AdminRepository)
class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl(this._isarService);

  final IsarService _isarService;

  @override
  Future<AdminUser> getAdminProfile({
    required String adminId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final profileJson = prefs.getString('admin_profile_$adminId');
      if (profileJson == null || profileJson.isEmpty) {
        throw Exception('Admin profile not found');
      }

      final profile = jsonDecode(profileJson) as Map<String, dynamic>;
      return AdminUser.fromJson(profile);
    } catch (e) {
      throw Exception('Failed to get admin profile: $e');
    }
  }

  @override
  Future<AdminStats> getDashboardStats() async {
    try {
      final prefs = _isarService.prefs;
      final statsJson = prefs.getString('admin_dashboard_stats');
      if (statsJson == null || statsJson.isEmpty) {
        // Return default stats
        return const AdminStats(
          totalUsers: 0,
          totalJobs: 0,
          totalApplications: 0,
          activeSubscriptions: 0,
        );
      }

      final stats = jsonDecode(statsJson) as Map<String, dynamic>;
      return AdminStats.fromJson(stats);
    } catch (e) {
      throw Exception('Failed to get dashboard stats: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllUsers({
    int page = 1,
    int limit = 20,
    String? role,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final usersJson = prefs.getString('all_users_list');
      if (usersJson == null || usersJson.isEmpty) {
        return <Map<String, dynamic>>[];
      }

      final usersList = jsonDecode(usersJson) as List<dynamic>;
      var users = usersList.cast<Map<String, dynamic>>();

      // Filter by role if provided
      if (role != null) {
        users = users.where((user) => user['role'] == role).toList();
      }

      // Implement pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      if (startIndex >= users.length) {
        return <Map<String, dynamic>>[];
      }

      return users.sublist(
        startIndex,
        endIndex.clamp(0, users.length),
      );
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllJobs({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final jobsJson = prefs.getString('all_jobs_list');
      if (jobsJson == null || jobsJson.isEmpty) {
        return <Map<String, dynamic>>[];
      }

      final jobsList = jsonDecode(jobsJson) as List<dynamic>;
      var jobs = jobsList.cast<Map<String, dynamic>>();

      // Filter by status if provided
      if (status != null) {
        jobs = jobs.where((job) => job['status'] == status).toList();
      }

      // Implement pagination
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
      throw Exception('Failed to get all jobs: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllApplications({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final applicationsJson = prefs.getString('all_applications_list');
      if (applicationsJson == null || applicationsJson.isEmpty) {
        return <Map<String, dynamic>>[];
      }

      final applicationsList = jsonDecode(applicationsJson) as List<dynamic>;
      var applications = applicationsList.cast<Map<String, dynamic>>();

      // Filter by status if provided
      if (status != null) {
        applications = applications
            .where((app) => app['status'] == status)
            .toList();
      }

      // Implement pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      if (startIndex >= applications.length) {
        return <Map<String, dynamic>>[];
      }

      return applications.sublist(
        startIndex,
        endIndex.clamp(0, applications.length),
      );
    } catch (e) {
      throw Exception('Failed to get all applications: $e');
    }
  }

  @override
  Future<void> updateUserStatus({
    required String userId,
    required bool isActive,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final usersJson = prefs.getString('all_users_list');
      if (usersJson == null || usersJson.isEmpty) {
        return;
      }

      final usersList = jsonDecode(usersJson) as List<dynamic>;
      final users = usersList.cast<Map<String, dynamic>>();

      final userIndex = users.indexWhere((user) => user['id'] == userId);
      if (userIndex != -1) {
        users[userIndex]['isActive'] = isActive;
        final updatedJson = jsonEncode(users);
        await prefs.setString('all_users_list', updatedJson);
      }
    } catch (e) {
      throw Exception('Failed to update user status: $e');
    }
  }

  @override
  Future<void> deleteUser({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final usersJson = prefs.getString('all_users_list');
      if (usersJson == null || usersJson.isEmpty) {
        return;
      }

      final usersList = jsonDecode(usersJson) as List<dynamic>;
      final users = usersList.cast<Map<String, dynamic>>();

      users.removeWhere((user) => user['id'] == userId);

      final updatedJson = jsonEncode(users);
      await prefs.setString('all_users_list', updatedJson);
      await prefs.remove('user_profile_$userId');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<void> updateJobStatus({
    required String jobId,
    required String status,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final jobsJson = prefs.getString('all_jobs_list');
      if (jobsJson == null || jobsJson.isEmpty) {
        return;
      }

      final jobsList = jsonDecode(jobsJson) as List<dynamic>;
      final jobs = jobsList.cast<Map<String, dynamic>>();

      final jobIndex = jobs.indexWhere((job) => job['id'] == jobId);
      if (jobIndex != -1) {
        jobs[jobIndex]['status'] = status;
        final updatedJson = jsonEncode(jobs);
        await prefs.setString('all_jobs_list', updatedJson);
      }
    } catch (e) {
      throw Exception('Failed to update job status: $e');
    }
  }

  @override
  Future<void> deleteJob({
    required String jobId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final jobsJson = prefs.getString('all_jobs_list');
      if (jobsJson == null || jobsJson.isEmpty) {
        return;
      }

      final jobsList = jsonDecode(jobsJson) as List<dynamic>;
      final jobs = jobsList.cast<Map<String, dynamic>>();

      jobs.removeWhere((job) => job['id'] == jobId);

      final updatedJson = jsonEncode(jobs);
      await prefs.setString('all_jobs_list', updatedJson);
    } catch (e) {
      throw Exception('Failed to delete job: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSystemLogs({
    int page = 1,
    int limit = 50,
    String? level,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final logsJson = prefs.getString('system_logs');
      if (logsJson == null || logsJson.isEmpty) {
        return <Map<String, dynamic>>[];
      }

      final logsList = jsonDecode(logsJson) as List<dynamic>;
      var logs = logsList.cast<Map<String, dynamic>>();

      // Filter by level if provided
      if (level != null) {
        logs = logs.where((log) => log['level'] == level).toList();
      }

      // Implement pagination
      final startIndex = (page - 1) * limit;
      final endIndex = startIndex + limit;
      if (startIndex >= logs.length) {
        return <Map<String, dynamic>>[];
      }

      return logs
          .sublist(
            startIndex,
            endIndex.clamp(0, logs.length),
          )
          .reversed
          .toList(); // Return in reverse chronological order
    } catch (e) {
      throw Exception('Failed to get system logs: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getAnalytics({
    required String timeframe,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final analyticsJson = prefs.getString('analytics_$timeframe');
      if (analyticsJson == null || analyticsJson.isEmpty) {
        return <String, dynamic>{
          'timeframe': timeframe,
          'data': <String, dynamic>{},
        };
      }

      final analytics = jsonDecode(analyticsJson) as Map<String, dynamic>;
      return analytics;
    } catch (e) {
      throw Exception('Failed to get analytics: $e');
    }
  }

  @override
  Future<String> exportData({
    required String type,
    required String format,
  }) async {
    try {
      // In a real implementation, this would generate and return a download URL
      // For now, return a mock URL
      return 'https://example.com/exports/${type}_${DateTime.now().millisecondsSinceEpoch}.$format';
    } catch (e) {
      throw Exception('Failed to export data: $e');
    }
  }
}

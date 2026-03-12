import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_repository.freezed.dart';
part 'admin_repository.g.dart';

@freezed
sealed class AdminUser with _$AdminUser {
  const factory AdminUser({
    required String id,
    required String name,
    required String email,
    required String role,
    @Default([]) List<String> permissions,
    DateTime? lastLogin,
    @Default(true) bool isActive,
  }) = _AdminUser;

  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);
}

@freezed
sealed class AdminStats with _$AdminStats {
  const factory AdminStats({
    required int totalUsers,
    required int totalJobs,
    required int totalApplications,
    required int activeSubscriptions,
    @Default([]) List<Map<String, int>> dailySignups,
    @Default([]) List<Map<String, int>> jobPostingStats,
  }) = _AdminStats;

  factory AdminStats.fromJson(Map<String, dynamic> json) =>
      _$AdminStatsFromJson(json);
}

/// Repository interface for admin operations
/// Defines the contract for admin dashboard data operations
abstract class AdminRepository {
  /// Get admin user profile
  /// Returns [AdminUser]
  Future<AdminUser> getAdminProfile({
    required String adminId,
  });

  /// Get admin dashboard statistics
  /// Returns [AdminStats]
  Future<AdminStats> getDashboardStats();

  /// Get all users (for admin management)
  /// Returns list of user data
  Future<List<Map<String, dynamic>>> getAllUsers({
    int page = 1,
    int limit = 20,
    String? role,
  });

  /// Get all jobs (for admin management)
  /// Returns list of job data
  Future<List<Map<String, dynamic>>> getAllJobs({
    int page = 1,
    int limit = 20,
    String? status,
  });

  /// Get all job applications (for admin management)
  /// Returns list of application data
  Future<List<Map<String, dynamic>>> getAllApplications({
    int page = 1,
    int limit = 20,
    String? status,
  });

  /// Update user status (activate/deactivate)
  /// Returns void when operation is complete
  Future<void> updateUserStatus({
    required String userId,
    required bool isActive,
  });

  /// Delete a user
  /// Returns void when operation is complete
  Future<void> deleteUser({
    required String userId,
  });

  /// Update job status
  /// Returns void when operation is complete
  Future<void> updateJobStatus({
    required String jobId,
    required String status,
  });

  /// Delete a job
  /// Returns void when operation is complete
  Future<void> deleteJob({
    required String jobId,
  });

  /// Get system logs
  /// Returns list of log entries
  Future<List<Map<String, dynamic>>> getSystemLogs({
    int page = 1,
    int limit = 50,
    String? level,
  });

  /// Get analytics data
  /// Returns map of analytics data
  Future<Map<String, dynamic>> getAnalytics({
    required String timeframe, // 'week', 'month', 'year'
  });

  /// Export data
  /// Returns download URL or base64 data
  Future<String> exportData({
    required String type, // 'users', 'jobs', 'applications'
    required String format, // 'csv', 'json', 'pdf'
  });
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/admin/domain/repositories/admin_repository.dart';

part 'admin_state.dart';
part 'admin_cubit.freezed.dart';
part 'admin_cubit.g.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit(this._repository) : super(const AdminState());

  final AdminRepository _repository;

  /// Get admin profile
  Future<void> getAdminProfile(String adminId) async {
    emit(
      state.copyWith(
        status: AdminStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final profile = await _repository.getAdminProfile(adminId: adminId);

      emit(
        state.copyWith(
          status: AdminStatus.loaded,
          adminProfile: profile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get dashboard statistics
  Future<void> getDashboardStats() async {
    emit(
      state.copyWith(
        status: AdminStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final stats = await _repository.getDashboardStats();

      emit(
        state.copyWith(
          status: AdminStatus.loaded,
          dashboardStats: stats,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get all users
  Future<void> getAllUsers({
    int page = 1,
    int limit = 20,
    String? role,
  }) async {
    emit(
      state.copyWith(
        status: AdminStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final users = await _repository.getAllUsers(
        page: page,
        limit: limit,
        role: role,
      );

      emit(
        state.copyWith(
          status: AdminStatus.loaded,
          users: users,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get all jobs
  Future<void> getAllJobs({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    emit(
      state.copyWith(
        status: AdminStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final jobs = await _repository.getAllJobs(
        page: page,
        limit: limit,
        status: status,
      );

      emit(
        state.copyWith(
          status: AdminStatus.loaded,
          jobs: jobs,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get all applications
  Future<void> getAllApplications({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    emit(
      state.copyWith(
        status: AdminStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final applications = await _repository.getAllApplications(
        page: page,
        limit: limit,
        status: status,
      );

      emit(
        state.copyWith(
          status: AdminStatus.loaded,
          applications: applications,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update user status
  Future<void> updateUserStatus({
    required String userId,
    required bool isActive,
  }) async {
    try {
      await _repository.updateUserStatus(
        userId: userId,
        isActive: isActive,
      );

      // Refresh users list
      await getAllUsers();
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Delete user
  Future<void> deleteUser(String userId) async {
    try {
      await _repository.deleteUser(userId: userId);

      // Refresh users list
      await getAllUsers();
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update job status
  Future<void> updateJobStatus({
    required String jobId,
    required String status,
  }) async {
    try {
      await _repository.updateJobStatus(
        jobId: jobId,
        status: status,
      );

      // Refresh jobs list
      await getAllJobs();
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Delete job
  Future<void> deleteJob(String jobId) async {
    try {
      await _repository.deleteJob(jobId: jobId);

      // Refresh jobs list
      await getAllJobs();
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get system logs
  Future<void> getSystemLogs({
    int page = 1,
    int limit = 50,
    String? level,
  }) async {
    emit(
      state.copyWith(
        status: AdminStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final logs = await _repository.getSystemLogs(
        page: page,
        limit: limit,
        level: level,
      );

      emit(
        state.copyWith(
          status: AdminStatus.loaded,
          systemLogs: logs,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get analytics data
  Future<void> getAnalytics(String timeframe) async {
    emit(
      state.copyWith(
        status: AdminStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final analytics = await _repository.getAnalytics(timeframe: timeframe);

      emit(
        state.copyWith(
          status: AdminStatus.loaded,
          analytics: analytics,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Export data
  Future<void> exportData({
    required String type,
    required String format,
  }) async {
    emit(
      state.copyWith(
        status: AdminStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final exportUrl = await _repository.exportData(
        type: type,
        format: format,
      );

      emit(
        state.copyWith(
          status: AdminStatus.loaded,
          exportDataUrl: exportUrl,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AdminStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear error
  void clearError() {
    emit(
      state.copyWith(
        errorMessage: '',
        status: AdminStatus.loaded,
      ),
    );
  }

  /// Reset state
  void reset() {
    emit(const AdminState());
  }
}

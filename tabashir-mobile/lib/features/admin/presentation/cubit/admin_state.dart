part of 'admin_cubit.dart';

@freezed
sealed class AdminState with _$AdminState {
  const factory AdminState({
    @Default(AdminStatus.initial) AdminStatus status,
    @Default('') String errorMessage,
    AdminUser? adminProfile,
    AdminStats? dashboardStats,
    @Default([]) List<Map<String, dynamic>> users,
    @Default([]) List<Map<String, dynamic>> jobs,
    @Default([]) List<Map<String, dynamic>> applications,
    @Default([]) List<Map<String, dynamic>> systemLogs,
    Map<String, dynamic>? analytics,
    String? exportDataUrl,
  }) = _AdminState;

  factory AdminState.fromJson(Map<String, dynamic> json) =>
      _$AdminStateFromJson(json);
}

enum AdminStatus {
  initial,
  loading,
  loaded,
  error,
}

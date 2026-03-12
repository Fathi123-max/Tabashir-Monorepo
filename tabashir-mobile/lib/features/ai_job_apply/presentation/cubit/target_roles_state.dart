part of 'target_roles_cubit.dart';

/// State for target roles selection
@freezed
sealed class TargetRolesState with _$TargetRolesState {
  /// Creates the initial state
  const factory TargetRolesState({
    /// List of available roles to select from
    @Default([]) List<TargetRoleModel> availableRoles,

    /// Currently selected roles
    @Default([]) List<TargetRoleModel> selectedRoles,

    /// Current custom role input
    @Default('') String customRoleTitle,

    /// AI suggestion for additional role
    TargetRoleModel? aiSuggestion,

    /// Submitting state
    @Default(false) bool isSubmitting,

    /// Error state
    @Default(false) bool hasError,

    /// Error message
    @Default('') String errorMessage,
  }) = _TargetRolesState;
}

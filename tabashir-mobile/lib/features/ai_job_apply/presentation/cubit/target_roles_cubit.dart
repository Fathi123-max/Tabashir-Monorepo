import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/ai_job_apply/data/models/target_role_model.dart';

part 'target_roles_cubit.freezed.dart';
part 'target_roles_state.dart';

/// Cubit for managing target roles selection state
class TargetRolesCubit extends Cubit<TargetRolesState> {
  /// Creates the target roles cubit
  TargetRolesCubit() : super(const TargetRolesState()) {
    _initializeDefaultRoles();
  }

  /// Initializes default role options
  void _initializeDefaultRoles() {
    final defaultRoles = <TargetRoleModel>[
      const TargetRoleModel(
        id: '1',
        title: 'Full Stack Developer',
        description: 'Updated today',
        matchScore: 92,
      ),
      const TargetRoleModel(
        id: '2',
        title: 'Frontend Engineer',
        description: 'Popular choice',
        matchScore: 88,
      ),
      const TargetRoleModel(
        id: '3',
        title: 'React Native Developer',
        description: 'Mobile development',
        matchScore: 85,
      ),
      const TargetRoleModel(
        id: '4',
        title: 'Backend Engineer',
        description: 'Server-side development',
        matchScore: 90,
      ),
    ];

    emit(
      state.copyWith(
        availableRoles: defaultRoles,
        selectedRoles: [defaultRoles.first], // Pre-select Full Stack Developer
      ),
    );
  }

  /// Toggles a role selection
  void toggleRole(TargetRoleModel role) {
    final selectedRoles = List<TargetRoleModel>.from(state.selectedRoles);

    if (selectedRoles.any((r) => r.id == role.id)) {
      selectedRoles.removeWhere((r) => r.id == role.id);
    } else {
      selectedRoles.add(role);
    }

    emit(
      state.copyWith(
        selectedRoles: selectedRoles,
        customRoleTitle: '',
      ),
    );

    _checkRoleSuggestion();
  }

  /// Adds a custom role
  void addCustomRole(String title) {
    if (title.trim().isEmpty) return;

    final customRole = TargetRoleModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      isCustom: true,
      potentialRoles: _calculatePotentialRoles(title),
    );

    final selectedRoles = List<TargetRoleModel>.from(state.selectedRoles);
    selectedRoles.add(customRole);

    emit(
      state.copyWith(
        selectedRoles: selectedRoles,
        customRoleTitle: '',
      ),
    );

    _checkRoleSuggestion();
  }

  /// Removes a role from selection
  void removeRole(String roleId) {
    final selectedRoles = List<TargetRoleModel>.from(state.selectedRoles);
    selectedRoles.removeWhere((r) => r.id == roleId);

    emit(state.copyWith(selectedRoles: selectedRoles));
    _checkRoleSuggestion();
  }

  /// Updates custom role input
  void updateCustomRoleTitle(String title) {
    emit(state.copyWith(customRoleTitle: title));
  }

  /// Continues with selected roles
  Future<void> continueWithSelectedRoles() async {
    if (state.selectedRoles.isEmpty) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: 'Please select at least one role',
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    try {
      // TODO: Implement actual navigation logic
      // This would proceed to the next step in AI apply flow

      emit(state.copyWith(isSubmitting: false));
    } catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          hasError: true,
          errorMessage: 'Failed to continue',
        ),
      );
    }
  }

  /// Checks and updates AI role suggestion
  void _checkRoleSuggestion() {
    // Example: Suggest "Team Lead" if user has selected developer roles
    final hasDeveloperRole = state.selectedRoles.any(
      (r) =>
          r.title.toLowerCase().contains('developer') ||
          r.title.toLowerCase().contains('engineer'),
    );

    if (hasDeveloperRole &&
        !state.selectedRoles.any((r) => r.title == 'Team Lead')) {
      emit(
        state.copyWith(
          aiSuggestion: const TargetRoleModel(
            id: 'suggestion',
            title: 'Team Lead',
            isCustom: true,
            potentialRoles: 8,
            description: "Adding 'Team Lead' could unlock 8 senior roles.",
          ),
        ),
      );
    } else {
      emit(state.copyWith(aiSuggestion: null));
    }
  }

  /// Calculates potential roles for a custom title
  int _calculatePotentialRoles(String title) {
    // TODO: Implement actual AI logic to calculate potential roles
    // This is a placeholder implementation
    final lowerTitle = title.toLowerCase();
    if (lowerTitle.contains('senior') || lowerTitle.contains('lead')) return 12;
    if (lowerTitle.contains('manager')) return 15;
    return 8;
  }

  /// Clears the error state
  void clearError() {
    emit(state.copyWith(hasError: false, errorMessage: ''));
  }
}

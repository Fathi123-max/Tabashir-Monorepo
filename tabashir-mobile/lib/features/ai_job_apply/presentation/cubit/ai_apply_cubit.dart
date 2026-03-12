import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/config/animation_config.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/features/ai_job_apply/data/models/resume_selection_model.dart';

part 'ai_apply_cubit.freezed.dart';
part 'ai_apply_state.dart';

/// Cubit for managing AI job application state
class AiApplyCubit extends Cubit<AiApplyState> {
  /// Creates the AI apply cubit
  AiApplyCubit() : super(const AiApplyState()) {
    _loadResumes();
  }

  /// Loads available resumes for selection
  Future<void> _loadResumes() async {
    emit(state.copyWith(isLoading: true));

    try {
      // TODO: Replace with actual repository call
      final resumes = <ResumeSelectionModel>[
        ResumeSelectionModel(
          id: '1',
          title: 'Full Stack Dev',
          lastUpdated: DateTime.now(), // Updated today
          matchPercentage: 92,
          isRecommended: true,
          description: 'Updated today',
        ),
        ResumeSelectionModel(
          id: '2',
          title: 'Marketing Specialist',
          lastUpdated: DateTime.now().subtract(
            AnimationConfig.resumeExpiration,
          ), // Last used 2 weeks ago
          description: 'Last used 2 weeks ago',
        ),
      ];

      emit(
        state.copyWith(
          isLoading: false,
          resumes: resumes,
          selectedResumeId: resumes
              .firstWhere(
                (r) => r.isRecommended,
                orElse: () => resumes.first,
              )
              .id,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: 'Failed to load resumes',
        ),
      );
    }
  }

  /// Selects a resume for AI job application
  void selectResume(String resumeId) {
    emit(state.copyWith(selectedResumeId: resumeId));
  }

  /// Continues with the selected resume
  Future<void> continueWithSelectedResume() async {
    if (state.selectedResumeId == null) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: 'Please select a resume to continue',
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    try {
      // TODO: Implement actual AI apply logic
      // This would trigger the AI job application process

      emit(state.copyWith(isSubmitting: false));
    } catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          hasError: true,
          errorMessage: 'Failed to continue with AI apply',
        ),
      );
    }
  }

  /// Creates a new resume with AI
  Future<void> createNewResumeWithAI() async {
    emit(state.copyWith(isCreatingNew: true));

    try {
      // TODO: Navigate to AI resume builder
      // This would open the AI resume builder flow

      emit(state.copyWith(isCreatingNew: false));
    } catch (error) {
      emit(
        state.copyWith(
          isCreatingNew: false,
          hasError: true,
          errorMessage: 'Failed to create new resume',
        ),
      );
    }
  }

  /// Clears the error state
  void clearError() {
    emit(state.copyWith(hasError: false, errorMessage: ''));
  }
}

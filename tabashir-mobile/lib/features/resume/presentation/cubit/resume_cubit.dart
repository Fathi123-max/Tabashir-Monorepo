import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/resume/data/models/resume_model.dart';
import 'package:tabashir/features/resume/domain/repositories/resume_repository.dart';

part 'resume_state.dart';
part 'resume_cubit.freezed.dart';
part 'resume_cubit.g.dart';

class ResumeCubit extends Cubit<ResumeState> {
  ResumeCubit(this._repository) : super(const ResumeState());

  final ResumeRepository _repository;

  /// Get resume by ID
  Future<void> getResume(String resumeId) async {
    emit(
      state.copyWith(
        status: ResumeCubitStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final resume = await _repository.getResume(resumeId: resumeId);

      emit(
        state.copyWith(
          status: ResumeCubitStatus.loaded,
          currentResume: resume,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get all user resumes
  Future<void> getUserResumes(String userId) async {
    emit(
      state.copyWith(
        status: ResumeCubitStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final resumes = await _repository.getUserResumes(userId: userId);

      emit(
        state.copyWith(
          status: ResumeCubitStatus.loaded,
          resumes: resumes,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Create resume
  Future<void> createResume(Resume resume) async {
    emit(
      state.copyWith(
        status: ResumeCubitStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final createdResume = await _repository.createResume(resume: resume);

      final updatedResumes = List<Resume>.from(state.resumes)
        ..add(createdResume);

      emit(
        state.copyWith(
          status: ResumeCubitStatus.loaded,
          resumes: updatedResumes,
          currentResume: createdResume,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update resume
  Future<void> updateResume({
    required String resumeId,
    required Resume resume,
  }) async {
    try {
      final updatedResume = await _repository.updateResume(
        resumeId: resumeId,
        resume: resume,
      );

      final updatedResumes = state.resumes
          .map((r) => r.id == resumeId ? updatedResume : r)
          .toList();

      emit(
        state.copyWith(
          status: ResumeCubitStatus.loaded,
          resumes: updatedResumes,
          currentResume: updatedResume,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Delete resume
  Future<void> deleteResume(String resumeId) async {
    try {
      await _repository.deleteResume(resumeId: resumeId);

      final updatedResumes = state.resumes
          .where((r) => r.id != resumeId)
          .toList();

      final currentResume = state.currentResume?.id == resumeId
          ? null
          : state.currentResume;

      emit(
        state.copyWith(
          status: ResumeCubitStatus.loaded,
          resumes: updatedResumes,
          currentResume: currentResume,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Duplicate resume
  Future<void> duplicateResume({
    required String resumeId,
    String? newTitle,
  }) async {
    emit(
      state.copyWith(
        status: ResumeCubitStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final duplicatedResume = await _repository.duplicateResume(
        resumeId: resumeId,
        newTitle: newTitle,
      );

      final updatedResumes = List<Resume>.from(state.resumes)
        ..add(duplicatedResume);

      emit(
        state.copyWith(
          status: ResumeCubitStatus.loaded,
          resumes: updatedResumes,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Export resume to PDF
  Future<void> exportResumeToPdf(String resumeId) async {
    emit(
      state.copyWith(
        status: ResumeCubitStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final exportUrl = await _repository.exportResumeToPdf(
        resumeId: resumeId,
      );

      emit(
        state.copyWith(
          status: ResumeCubitStatus.loaded,
          exportUrl: exportUrl,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Export resume to Word
  Future<void> exportResumeToWord(String resumeId) async {
    emit(
      state.copyWith(
        status: ResumeCubitStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final exportUrl = await _repository.exportResumeToWord(
        resumeId: resumeId,
      );

      emit(
        state.copyWith(
          status: ResumeCubitStatus.loaded,
          exportUrl: exportUrl,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Add work experience
  Future<void> addWorkExperience({
    required String resumeId,
    required WorkExperience experience,
  }) async {
    try {
      await _repository.addWorkExperience(
        resumeId: resumeId,
        experience: experience,
      );

      // Refresh current resume
      await getResume(resumeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update work experience
  Future<void> updateWorkExperience({
    required String resumeId,
    required int index,
    required WorkExperience experience,
  }) async {
    try {
      await _repository.updateWorkExperience(
        resumeId: resumeId,
        index: index,
        experience: experience,
      );

      // Refresh current resume
      await getResume(resumeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Remove work experience
  Future<void> removeWorkExperience({
    required String resumeId,
    required int index,
  }) async {
    try {
      await _repository.removeWorkExperience(
        resumeId: resumeId,
        index: index,
      );

      // Refresh current resume
      await getResume(resumeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Add education
  Future<void> addEducation({
    required String resumeId,
    required Education education,
  }) async {
    try {
      await _repository.addEducation(
        resumeId: resumeId,
        education: education,
      );

      // Refresh current resume
      await getResume(resumeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update education
  Future<void> updateEducation({
    required String resumeId,
    required int index,
    required Education education,
  }) async {
    try {
      await _repository.updateEducation(
        resumeId: resumeId,
        index: index,
        education: education,
      );

      // Refresh current resume
      await getResume(resumeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Remove education
  Future<void> removeEducation({
    required String resumeId,
    required int index,
  }) async {
    try {
      await _repository.removeEducation(
        resumeId: resumeId,
        index: index,
      );

      // Refresh current resume
      await getResume(resumeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Add skill
  Future<void> addSkill({
    required String resumeId,
    required Skill skill,
  }) async {
    try {
      await _repository.addSkill(
        resumeId: resumeId,
        skill: skill,
      );

      // Refresh current resume
      await getResume(resumeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update skill
  Future<void> updateSkill({
    required String resumeId,
    required int index,
    required Skill skill,
  }) async {
    try {
      await _repository.updateSkill(
        resumeId: resumeId,
        index: index,
        skill: skill,
      );

      // Refresh current resume
      await getResume(resumeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Remove skill
  Future<void> removeSkill({
    required String resumeId,
    required int index,
  }) async {
    try {
      await _repository.removeSkill(
        resumeId: resumeId,
        index: index,
      );

      // Refresh current resume
      await getResume(resumeId);
    } catch (e) {
      emit(
        state.copyWith(
          status: ResumeCubitStatus.error,
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
        status: ResumeCubitStatus.loaded,
      ),
    );
  }

  /// Reset state
  void reset() {
    emit(const ResumeState());
  }
}

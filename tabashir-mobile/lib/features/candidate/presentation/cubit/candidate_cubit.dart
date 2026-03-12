import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/candidate/domain/repositories/candidate_repository.dart';

part 'candidate_state.dart';
part 'candidate_cubit.freezed.dart';
part 'candidate_cubit.g.dart';

class CandidateCubit extends Cubit<CandidateState> {
  CandidateCubit(this._repository) : super(const CandidateState());

  final CandidateRepository _repository;

  /// Get candidate profile
  Future<void> getCandidateProfile(String candidateId) async {
    emit(
      state.copyWith(
        status: CandidateStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final profile = await _repository.getCandidateProfile(
        candidateId: candidateId,
      );

      emit(
        state.copyWith(
          status: CandidateStatus.loaded,
          profile: profile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Create candidate profile
  Future<void> createCandidateProfile(CandidateProfile profile) async {
    emit(
      state.copyWith(
        status: CandidateStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final createdProfile = await _repository.createCandidateProfile(
        profile: profile,
      );

      emit(
        state.copyWith(
          status: CandidateStatus.loaded,
          profile: createdProfile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update candidate profile
  Future<void> updateCandidateProfile({
    required String candidateId,
    required CandidateProfile profile,
  }) async {
    emit(
      state.copyWith(
        status: CandidateStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final updatedProfile = await _repository.updateCandidateProfile(
        candidateId: candidateId,
        profile: profile,
      );

      emit(
        state.copyWith(
          status: CandidateStatus.loaded,
          profile: updatedProfile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Delete candidate profile
  Future<void> deleteCandidateProfile(String candidateId) async {
    try {
      await _repository.deleteCandidateProfile(candidateId: candidateId);

      // Reset state
      emit(const CandidateState());
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get all candidates
  Future<void> getAllCandidates() async {
    emit(
      state.copyWith(
        status: CandidateStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final candidates = await _repository.getAllCandidates();

      emit(
        state.copyWith(
          status: CandidateStatus.loaded,
          allCandidates: candidates,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Search candidates
  Future<void> searchCandidates({
    required String query,
    String? location,
    String? experienceLevel,
  }) async {
    emit(
      state.copyWith(
        status: CandidateStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final results = await _repository.searchCandidates(
        query: query,
        location: location,
        experienceLevel: experienceLevel,
      );

      emit(
        state.copyWith(
          status: CandidateStatus.loaded,
          searchResults: results,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Add resume
  Future<void> addResume({
    required String candidateId,
    required String resumeUrl,
  }) async {
    try {
      await _repository.addResume(
        candidateId: candidateId,
        resumeUrl: resumeUrl,
      );

      // Refresh profile
      await getCandidateProfile(candidateId);
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Remove resume
  Future<void> removeResume({
    required String candidateId,
    required String resumeUrl,
  }) async {
    try {
      await _repository.removeResume(
        candidateId: candidateId,
        resumeUrl: resumeUrl,
      );

      // Refresh profile
      await getCandidateProfile(candidateId);
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Add job application
  Future<void> addJobApplication({
    required String candidateId,
    required String jobId,
  }) async {
    try {
      await _repository.addJobApplication(
        candidateId: candidateId,
        jobId: jobId,
      );

      // Refresh profile
      await getCandidateProfile(candidateId);
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Remove job application
  Future<void> removeJobApplication({
    required String candidateId,
    required String jobId,
  }) async {
    try {
      await _repository.removeJobApplication(
        candidateId: candidateId,
        jobId: jobId,
      );

      // Refresh profile
      await getCandidateProfile(candidateId);
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidateStatus.error,
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
        status: CandidateStatus.loaded,
      ),
    );
  }

  /// Reset state
  void reset() {
    emit(const CandidateState());
  }
}

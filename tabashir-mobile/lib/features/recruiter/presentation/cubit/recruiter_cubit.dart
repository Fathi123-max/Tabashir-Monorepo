import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/recruiter/data/models/recruiter_model.dart';
import 'package:tabashir/features/recruiter/domain/repositories/recruiter_repository.dart';

part 'recruiter_state.dart';
part 'recruiter_cubit.freezed.dart';
part 'recruiter_cubit.g.dart';

class RecruiterCubit extends Cubit<RecruiterState> {
  RecruiterCubit(this._repository) : super(const RecruiterState());

  final RecruiterRepository _repository;

  /// Get recruiter profile
  Future<void> getRecruiterProfile(String recruiterId) async {
    emit(
      state.copyWith(
        status: RecruiterStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final profile = await _repository.getRecruiterProfile(
        recruiterId: recruiterId,
      );

      emit(
        state.copyWith(
          status: RecruiterStatus.loaded,
          profile: profile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Create recruiter profile
  Future<void> createRecruiterProfile(RecruiterProfile profile) async {
    emit(
      state.copyWith(
        status: RecruiterStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final createdProfile = await _repository.createRecruiterProfile(
        profile: profile,
      );

      emit(
        state.copyWith(
          status: RecruiterStatus.loaded,
          profile: createdProfile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update recruiter profile
  Future<void> updateRecruiterProfile({
    required String recruiterId,
    required RecruiterProfile profile,
  }) async {
    try {
      final updatedProfile = await _repository.updateRecruiterProfile(
        recruiterId: recruiterId,
        profile: profile,
      );

      emit(
        state.copyWith(
          status: RecruiterStatus.loaded,
          profile: updatedProfile,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Create job posting
  Future<void> createJobPosting(JobPosting jobPosting) async {
    emit(
      state.copyWith(
        status: RecruiterStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final createdJob = await _repository.createJobPosting(
        jobPosting: jobPosting,
      );

      emit(
        state.copyWith(
          status: RecruiterStatus.loaded,
          currentJobPosting: createdJob,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update job posting
  Future<void> updateJobPosting({
    required String jobId,
    required JobPosting jobPosting,
  }) async {
    try {
      final updatedJob = await _repository.updateJobPosting(
        jobId: jobId,
        jobPosting: jobPosting,
      );

      emit(
        state.copyWith(
          status: RecruiterStatus.loaded,
          currentJobPosting: updatedJob,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Delete job posting
  Future<void> deleteJobPosting(String jobId) async {
    try {
      await _repository.deleteJobPosting(jobId: jobId);

      // Refresh job postings
      if (state.profile != null) {
        await getJobPostings(state.profile!.id);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get job postings
  Future<void> getJobPostings(String recruiterId, {JobStatus? status}) async {
    emit(
      state.copyWith(
        status: RecruiterStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final jobPostings = await _repository.getJobPostings(
        recruiterId: recruiterId,
        status: status,
      );

      emit(
        state.copyWith(
          status: RecruiterStatus.loaded,
          jobPostings: jobPostings,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get job posting by ID
  Future<void> getJobPosting(String jobId) async {
    emit(
      state.copyWith(
        status: RecruiterStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final jobPosting = await _repository.getJobPosting(jobId: jobId);

      emit(
        state.copyWith(
          status: RecruiterStatus.loaded,
          currentJobPosting: jobPosting,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get job applications
  Future<void> getJobApplications(String jobId) async {
    emit(
      state.copyWith(
        status: RecruiterStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final applications = await _repository.getJobApplications(jobId: jobId);

      emit(
        state.copyWith(
          status: RecruiterStatus.loaded,
          jobApplications: applications,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Update application status
  Future<void> updateApplicationStatus({
    required String applicationId,
    required ApplicationStatus status,
    String? notes,
  }) async {
    try {
      await _repository.updateApplicationStatus(
        applicationId: applicationId,
        status: status,
        notes: notes,
      );

      // Refresh current job applications if available
      if (state.currentJobPosting != null) {
        await getJobApplications(state.currentJobPosting!.id);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Add application note
  Future<void> addApplicationNote({
    required String applicationId,
    required String note,
  }) async {
    try {
      await _repository.addApplicationNote(
        applicationId: applicationId,
        note: note,
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Get all applications
  Future<void> getAllApplications(
    String recruiterId, {
    ApplicationStatus? status,
  }) async {
    emit(
      state.copyWith(
        status: RecruiterStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final applications = await _repository.getAllApplications(
        recruiterId: recruiterId,
        status: status,
      );

      emit(
        state.copyWith(
          status: RecruiterStatus.loaded,
          applications: applications,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RecruiterStatus.error,
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
        status: RecruiterStatus.loaded,
      ),
    );
  }

  /// Reset state
  void reset() {
    emit(const RecruiterState());
  }
}

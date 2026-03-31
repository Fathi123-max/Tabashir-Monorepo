import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/network/models/jobs_count_response.dart';
import 'package:tabashir/features/job_applications/domain/repositories/job_applications_repository.dart';

part 'job_applications_state.dart';
part 'job_applications_cubit.freezed.dart';
part 'job_applications_cubit.g.dart';

@injectable
class JobApplicationsCubit extends Cubit<JobApplicationsState> {
  JobApplicationsCubit(this._repository) : super(const JobApplicationsState());

  final JobApplicationsRepository _repository;

  /// Load all applied jobs for a user
  Future<void> loadAppliedJobs({required String email}) async {
    emit(state.copyWith(status: JobApplicationsStatus.loading));

    try {
      final response = await _repository.getAppliedJobs(email: email);
      final appliedJobs = response.jobs ?? <AppliedJob>[];

      emit(
        state.copyWith(
          status: JobApplicationsStatus.success,
          appliedJobs: appliedJobs,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: JobApplicationsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Load the count of applied jobs
  Future<void> loadApplicationsCount({required String email}) async {
    try {
      final response = await _repository.getAppliedJobsCount(email: email);
      emit(
        state.copyWith(totalApplications: response.appliedJobsCount),
      );
    } catch (e) {
      // Don't emit error state for count, just log it
      emit(
        state.copyWith(errorMessage: e.toString()),
      );
    }
  }

  /// Refresh both jobs and count
  Future<void> refresh({required String email}) async {
    await loadAppliedJobs(email: email);
    await loadApplicationsCount(email: email);
  }
}

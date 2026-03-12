import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/applied_jobs_storage.dart';
import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_cubit.dart';
import 'package:tabashir/features/jobs/data/models/job_details.dart';
import 'package:tabashir/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:tabashir/features/jobs/services/job_details_service.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';

part 'job_details_state.dart';
part 'job_details_cubit.freezed.dart';

/// Cubit for managing the state of the job details screen.
/// Handles loading, displaying, applying to, saving, and sharing job details.
class JobDetailsCubit extends Cubit<JobDetailsState> {
  /// Creates a new instance of [JobDetailsCubit] with the provided [service].
  JobDetailsCubit({
    required this.service,
    AppliedJobsStorage? appliedJobsStorage,
    ProfileCubit? profileCubit,
  }) : _appliedJobsStorage = appliedJobsStorage ?? getIt<AppliedJobsStorage>(),
       _profileCubit = profileCubit,
       super(const JobDetailsState.initial());
  final JobDetailsService service;
  final AppliedJobsStorage _appliedJobsStorage;
  final ProfileCubit? _profileCubit;

  /// Fetches job details for the given [jobId] and updates the state.
  /// Emits [JobDetailsState.loading] while fetching, [JobDetailsState.loaded]
  /// with the job details on success, or [JobDetailsState.error] on failure.
  Future<void> getJobDetails(String jobId) async {
    emit(const JobDetailsState.loading());

    try {
      final jobDetails = await service.getJobDetails(jobId);
      final appliedIds = await _appliedJobsStorage.getAppliedJobIds();
      emit(
        JobDetailsState.loaded(
          jobDetails: jobDetails,
          isApplied: appliedIds.contains(jobId),
        ),
      );
    } catch (e) {
      emit(JobDetailsState.error(e.toString()));
    }
  }

  /// Attempts to apply to the job with the given [jobId] using default resume.
  /// Uses the new AiJobApplyCubit for job-specific application.
  Future<void> applyToJob(String jobId) async {
    try {
      // Get user email from profile
      final profileCubit = _profileCubit ?? getIt<ProfileCubit>();
      final profileState = profileCubit.state;

      if (profileState.status != ProfileStatus.success ||
          profileState.profile?.email == null) {
        emit(
          const JobDetailsState.error(
            'User email not found. Please update your profile.',
          ),
        );
        return;
      }

      final email = profileState.profile!.email;

      // Use AiJobApplyCubit to apply with default resume
      final aiJobApplyCubit = getIt<AiJobApplyCubit>();
      await aiJobApplyCubit.applyToSpecificJob(
        jobId: jobId,
        email: email,
      );

      await _appliedJobsStorage.addAppliedJobId(jobId);
      if (getIt.isRegistered<JobsCubit>()) {
        getIt<JobsCubit>().markJobAsApplied(jobId);
      }

      if (state is JobDetailsLoaded) {
        final currentState = state as JobDetailsLoaded;
        emit(
          JobDetailsState.loaded(
            jobDetails: currentState.jobDetails,
            isApplied: true,
          ),
        );
      }
    } catch (e) {
      emit(JobDetailsState.error(e.toString()));
    }
  }

  /// Shares the job with the given [jobId] using the system's share functionality.
  Future<void> shareJob(String jobId) async {
    try {
      await service.shareJob(jobId);
      // No state change needed for sharing
    } catch (e) {
      emit(JobDetailsState.error(e.toString()));
    }
  }
}

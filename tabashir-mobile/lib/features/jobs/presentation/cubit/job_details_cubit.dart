import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/applied_jobs_storage.dart';
import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_cubit.dart';
import 'package:tabashir/features/jobs/data/models/job_details.dart';
import 'package:tabashir/core/services/isar_service.dart';
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
    SavedJobsRepository? savedJobsRepository,
    AppliedJobsStorage? appliedJobsStorage,
    ProfileCubit? profileCubit,
  }) : _savedJobsRepository =
           savedJobsRepository ?? getIt<SavedJobsRepository>(),
       _appliedJobsStorage = appliedJobsStorage ?? getIt<AppliedJobsStorage>(),
       _profileCubit = profileCubit,
       super(const JobDetailsState.initial()) {
    _savedJobsSubscription = _savedJobsRepository.savedJobsStream.listen((
      savedIds,
    ) {
      _updateSavedStatus(savedIds);
    });
  }

  final JobDetailsService service;
  final SavedJobsRepository _savedJobsRepository;
  final AppliedJobsStorage _appliedJobsStorage;
  final ProfileCubit? _profileCubit;
  StreamSubscription<Set<String>>? _savedJobsSubscription;

  @override
  Future<void> close() {
    _savedJobsSubscription?.cancel();
    return super.close();
  }

  /// Fetches job details for the given [jobId] and updates the state.
  /// Emits [JobDetailsState.loading] while fetching, [JobDetailsState.loaded]
  /// with the job details on success, or [JobDetailsState.error] on failure.
  Future<void> getJobDetails(String jobId) async {
    emit(const JobDetailsState.loading());

    try {
      final jobDetails = await service.getJobDetails(jobId);
      final appliedIds = await _appliedJobsStorage.getAppliedJobIds();
      final isSaved = await _savedJobsRepository.isJobSaved(jobId);

      emit(
        JobDetailsState.loaded(
          jobDetails: jobDetails,
          isApplied: appliedIds.contains(jobId),
          isSaved: isSaved,
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
          currentState.copyWith(
            isApplied: true,
          ),
        );
      }
    } catch (e) {
      emit(JobDetailsState.error(e.toString()));
    }
  }

  /// Toggles the saved status of the job.
  Future<void> toggleSaveJob(String jobId) async {
    final currentState = state;
    if (currentState is! JobDetailsLoaded) return;

    final isCurrentlySaved = currentState.isSaved;

    // Optimistic update
    emit(currentState.copyWith(isSaved: !isCurrentlySaved));

    try {
      if (isCurrentlySaved) {
        await _savedJobsRepository.removeSavedJob(jobId);
      } else {
        await _savedJobsRepository.saveJob(jobId);
      }
    } catch (e) {
      // Revert if API call fails
      emit(currentState.copyWith(isSaved: isCurrentlySaved));
      emit(JobDetailsState.error('Failed to update saved status: $e'));
    }
  }

  void _updateSavedStatus(Set<String> savedIds) {
    final currentState = state;
    if (currentState is JobDetailsLoaded) {
      final isSaved = savedIds.contains(currentState.jobDetails.id);
      if (isSaved != currentState.isSaved) {
        emit(currentState.copyWith(isSaved: isSaved));
      }
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

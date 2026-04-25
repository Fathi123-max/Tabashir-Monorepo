import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:tabashir/core/services/local_persistence_service.dart';
import 'package:tabashir/features/jobs/domain/models/job_ui_model.dart';
import 'package:tabashir/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:tabashir/core/utils/app_logger.dart';

part 'saved_jobs_state.dart';
part 'saved_jobs_cubit.freezed.dart';

@lazySingleton
class SavedJobsCubit extends Cubit<SavedJobsState> {
  SavedJobsCubit(this._repository) : super(const SavedJobsState.initial()) {
    _savedJobsSubscription = _repository.savedJobsStream.listen((savedIds) {
      AppLogger.debug('[SAVED_JOBS_CUBIT] Received saved jobs update: ${savedIds.length} IDs', tag: 'Jobs');
      if (state is SavedJobsStateLoaded) {
        final loadedState = state as SavedJobsStateLoaded;
        emit(loadedState.copyWith(savedJobs: savedIds));
      }
    });
  }

  final SavedJobsRepository _repository;
  StreamSubscription<Set<String>>? _savedJobsSubscription;

  @override
  Future<void> close() {
    _savedJobsSubscription?.cancel();
    return super.close();
  }

  /// Initialize the saved jobs screen with only saved jobs
  Future<void> initializeSavedJobs(JobsCubit jobsCubit) async {
    emit(const SavedJobsState.loading());
    // Ensure we have the latest saved IDs
    await loadSavedIds();

    final savedJobIds = state.maybeMap(
      loaded: (state) => state.savedJobs,
      orElse: () => <String>{},
    );

    AppLogger.debug('[SAVED_JOBS] Using ${savedJobIds.length} saved job IDs', tag: 'Jobs');

    // Get current jobs from JobsCubit
    final currentJobs = <JobUI>[];
    final currentState = jobsCubit.state;
    AppLogger.debug('[SAVED_JOBS] JobsCubit state type: ${currentState.runtimeType}', tag: 'Jobs');

    if (currentState is JobsStateLoaded) {
      AppLogger.debug('[SAVED_JOBS] JobsCubit is JobsStateLoaded, jobs count: ${currentState.jobs.length ?? 0}', tag: 'Jobs');
      currentJobs.addAll(
        currentState.jobs.where((job) => savedJobIds.contains(job.id)),
      );
      AppLogger.debug('[SAVED_JOBS] Added ${currentJobs.length} jobs to currentJobs', tag: 'Jobs');
    } else {
      AppLogger.debug('[SAVED_JOBS] JobsCubit is NOT JobsStateLoaded, current state: ${currentState.runtimeType}', tag: 'Jobs');
    }

    // Convert jobs to Map format expected by the UI
    final jobsMap = currentJobs.map((job) => job.toJson()).toList();
    AppLogger.debug('[SAVED_JOBS] Converted ${jobsMap.length} jobs to Map format', tag: 'Jobs');

    emit(
      SavedJobsState.loaded(
        jobs: jobsMap,
        savedJobs: savedJobIds,
        cardStyle: 'standard',
        isGridView: true,
        searchQuery: '',
      ),
    );
  }

  /// Load only the saved job IDs from the repository
  Future<void> loadSavedIds() async {
    try {
      final savedJobIds = await _repository.getAllSavedJobIds();
      AppLogger.debug('[SAVED_JOBS] Fetched ${savedJobIds.length} saved job IDs from API', tag: 'Jobs');

      // If state is already loaded, just update the IDs
      if (state is SavedJobsStateLoaded) {
        final loadedState = state as SavedJobsStateLoaded;
        emit(loadedState.copyWith(savedJobs: savedJobIds.toSet()));
      } else {
        // If not loaded, emit a loaded state with empty jobs list but populated IDs
        // This allows other screens to check isSaved status before the Saved Jobs screen is visited
        emit(
          SavedJobsState.loaded(
            jobs: [],
            savedJobs: savedJobIds.toSet(),
            cardStyle: 'standard',
            isGridView: true,
            searchQuery: '',
          ),
        );
      }
    } catch (e) {
      AppLogger.error('[SAVED_JOBS] Error loading saved IDs: $e', tag: 'Jobs', error: e);
      // Don't emit error state here to avoid blocking the whole app if this fails in background
    }
  }

  void updateSearchQuery(String query) {
    if (state is SavedJobsStateLoaded) {
      final loadedState = state as SavedJobsStateLoaded;
      emit(
        loadedState.copyWith(searchQuery: query),
      );
    }
  }

  void updateCardStyle(String style) {
    if (state is SavedJobsStateLoaded) {
      final loadedState = state as SavedJobsStateLoaded;
      emit(
        loadedState.copyWith(cardStyle: style),
      );
    }
  }

  void setGridView() {
    if (state is SavedJobsStateLoaded) {
      final loadedState = state as SavedJobsStateLoaded;
      emit(
        loadedState.copyWith(isGridView: true),
      );
    }
  }

  void setListView() {
    if (state is SavedJobsStateLoaded) {
      final loadedState = state as SavedJobsStateLoaded;
      emit(
        loadedState.copyWith(
          isGridView: false,
          cardStyle: 'minimal',
        ),
      );
    }
  }

  // Save/Unsave methods
  Future<void> saveJob(String jobId) async {
    AppLogger.debug('[SAVED_JOBS_CUBIT] saveJob() called for jobId: $jobId', tag: 'Jobs');
    if (state is SavedJobsStateLoaded) {
      final loadedState = state as SavedJobsStateLoaded;

      // Persist to database
      await _repository.saveJob(jobId);

      // Update state
      final updatedSavedJobs = Set<String>.from(loadedState.savedJobs)
        ..add(jobId);

      emit(
        loadedState.copyWith(savedJobs: updatedSavedJobs),
      );
    }
  }

  Future<void> unsaveJob(String jobId) async {
    AppLogger.debug('[SAVED_JOBS_CUBIT] unsaveJob() called for jobId: $jobId', tag: 'Jobs');
    if (state is SavedJobsStateLoaded) {
      final loadedState = state as SavedJobsStateLoaded;

      // Persist to database
      await _repository.removeSavedJob(jobId);

      // Update state
      final updatedSavedJobs = Set<String>.from(loadedState.savedJobs)
        ..remove(jobId);

      // Update jobs list to remove the unsaved job
      final updatedJobs = loadedState.jobs
          .where((job) => job['id'] as String != jobId)
          .toList();

      emit(
        loadedState.copyWith(
          savedJobs: updatedSavedJobs,
          jobs: updatedJobs,
        ),
      );
    }
  }

  Future<void> toggleSaveJob(String jobId) async {
    AppLogger.debug('[SAVED_JOBS_CUBIT] toggleSaveJob() called for jobId: $jobId', tag: 'Jobs');
    if (state is SavedJobsStateLoaded) {
      final loadedState = state as SavedJobsStateLoaded;
      if (loadedState.savedJobs.contains(jobId)) {
        await unsaveJob(jobId);
      } else {
        await saveJob(jobId);
      }
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/resume/domain/repositories/resume_vault_repository.dart';
import 'package:tabashir/core/utils/app_logger.dart';

part 'resume_vault_state.dart';
part 'resume_vault_cubit.freezed.dart';

@lazySingleton
class ResumeVaultCubit extends Cubit<ResumeVaultState> {
  ResumeVaultCubit(this._repository) : super(const ResumeVaultState()) {
    // Removed auto-load - resumes will be loaded when needed
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Cubit created (no auto-load)', tag: 'Resume');
  }

  final ResumeVaultRepository _repository;
  bool _isLoading = false;
  bool _isInitialized = false; // Track initialization state

  /// Initialize resumes (called once, typically from AppInitializationCubit)
  Future<void> initializeWithResumes(List<ResumeItem> resumes) async {
    if (_isInitialized) {
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Already initialized, skipping', tag: 'Resume');
      return;
    }

    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Initializing with ${resumes.length} resumes from shared data', tag: 'Resume');
    if (!isClosed) {
      emit(
        state.copyWith(
          status: ResumeVaultStatus.success,
          resumes: resumes,
        ),
      );
    }
    _isInitialized = true;
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Resume vault initialized with shared data', tag: 'Resume');
  }

  Future<void> loadResumes({bool force = false}) async {
    // Prevent duplicate concurrent loads
    if (_isLoading && !force) {
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Already loading, skipping duplicate call', tag: 'Resume');
      return;
    }

    // Skip if already loaded and not forced
    if (!force &&
        state.status == ResumeVaultStatus.success &&
        state.resumes.isNotEmpty) {
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Already loaded, skipping', tag: 'Resume');
      return;
    }

    // If not initialized yet, don't auto-load - wait for initializeWithResumes
    if (!_isInitialized && !force) {
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Not initialized yet, skipping auto-load. Call initializeWithResumes() first.', tag: 'Resume');
      return;
    }

    _isLoading = true;
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] loadResumes() called', tag: 'Resume');
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Current state: ${state.status}', tag: 'Resume');
    if (!isClosed) {
      emit(state.copyWith(status: ResumeVaultStatus.loading));
    }
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Emitted loading state', tag: 'Resume');

    try {
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Fetching resumes from repository...', tag: 'Resume');
      final resumes = await _repository.getUserResumes();
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Fetched ${resumes.length} resumes from repository', tag: 'Resume');
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Resume IDs: ${resumes.map((r) => r.id).join(', ')}', tag: 'Resume');

      if (!isClosed) {
        emit(
          state.copyWith(
            status: ResumeVaultStatus.success,
            resumes: resumes,
          ),
        );
      }
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted success state with ${resumes.length} resumes', tag: 'Resume');
    } catch (e, stackTrace) {
      AppLogger.error('🔴 [RESUME_VAULT_CUBIT]', tag: 'Resume', error: e, stackTrace: stackTrace);
      if (!isClosed) {
        emit(
          state.copyWith(
            status: ResumeVaultStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Emitted failure state', tag: 'Resume');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteResume(String id) async {
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] deleteResume() called for ID: $id', tag: 'Resume');
    if (!isClosed) {
      emit(state.copyWith(status: ResumeVaultStatus.deleting));
    }

    try {
      await _repository.deleteResume(resumeId: id);
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Repository delete successful', tag: 'Resume');

      final updatedResumes = state.resumes.where((r) => r.id != id).toList();
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Updated resumes count: ${updatedResumes.length}', tag: 'Resume');

      if (!isClosed) {
        emit(
          state.copyWith(
            resumes: updatedResumes,
            status: ResumeVaultStatus.success,
          ),
        );
      }
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted success state after delete', tag: 'Resume');
    } catch (e, stackTrace) {
      AppLogger.error('🔴 [RESUME_VAULT_CUBIT]', tag: 'Resume', error: e, stackTrace: stackTrace);
      if (!isClosed) {
        emit(
          state.copyWith(
            status: ResumeVaultStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> setDefaultResume(String id) async {
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] setDefaultResume() called for ID: $id', tag: 'Resume');
    try {
      await _repository.setDefaultResume(resumeId: id);
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Repository setDefault successful', tag: 'Resume');

      final updatedResumes = state.resumes
          .map(
            (resume) => resume.copyWith(isDefault: resume.id == id),
          )
          .toList();

      if (!isClosed) {
        emit(state.copyWith(resumes: updatedResumes));
      }
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted state with updated default', tag: 'Resume');
    } catch (e, stackTrace) {
      AppLogger.error('🔴 [RESUME_VAULT_CUBIT]', tag: 'Resume', error: e, stackTrace: stackTrace);
      if (!isClosed) {
        emit(
          state.copyWith(
            status: ResumeVaultStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> duplicateResume(String id) async {
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] duplicateResume() called for ID: $id', tag: 'Resume');
    try {
      final duplicatedResume = await _repository.duplicateResume(resumeId: id);
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Duplicated resume: ${duplicatedResume.id}', tag: 'Resume');

      final updatedResumes = [duplicatedResume, ...state.resumes];
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Total resumes after duplicate: ${updatedResumes.length}', tag: 'Resume');

      if (!isClosed) {
        emit(state.copyWith(resumes: updatedResumes));
      }
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted state with duplicated resume', tag: 'Resume');
    } catch (e, stackTrace) {
      AppLogger.error('🔴 [RESUME_VAULT_CUBIT]', tag: 'Resume', error: e, stackTrace: stackTrace);
      if (!isClosed) {
        emit(
          state.copyWith(
            status: ResumeVaultStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> renameResume(String id, String newName) async {
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] renameResume() called for ID: $id to name: $newName', tag: 'Resume');
    try {
      final updatedResume = await _repository.renameResume(
        resumeId: id,
        newName: newName,
      );
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Renamed resume to: ${updatedResume.name}', tag: 'Resume');

      final updatedResumes = state.resumes.map((resume) {
        if (resume.id == id) {
          return updatedResume;
        }
        return resume;
      }).toList();

      if (!isClosed) {
        emit(state.copyWith(resumes: updatedResumes));
      }
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted state with renamed resume', tag: 'Resume');
    } catch (e, stackTrace) {
      AppLogger.error('🔴 [RESUME_VAULT_CUBIT]', tag: 'Resume', error: e, stackTrace: stackTrace);
      if (!isClosed) {
        emit(
          state.copyWith(
            status: ResumeVaultStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }

  Future<void> uploadResume({
    required String fileName,
    required String filePath,
    required String fileType,
    required int fileSize,
  }) async {
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] uploadResume() called', tag: 'Resume');
    AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] File: $fileName, Path: $filePath, Size: $fileSize bytes', tag: 'Resume');
    if (!isClosed) {
      emit(state.copyWith(status: ResumeVaultStatus.uploading));
    }

    try {
      final newResume = await _repository.uploadResume(
        fileName: fileName,
        filePath: filePath,
        fileType: fileType,
        fileSize: fileSize,
      );
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Uploaded resume: ${newResume.id}', tag: 'Resume');

      final updatedResumes = [newResume, ...state.resumes];
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Total resumes after upload: ${updatedResumes.length}', tag: 'Resume');

      if (!isClosed) {
        emit(
          state.copyWith(
            status: ResumeVaultStatus.success,
            resumes: updatedResumes,
          ),
        );
      }
      AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted success state with new resume', tag: 'Resume');

      // Trigger AI Dashboard Refresh
      try {
        AppLogger.debug('🔵 [RESUME_VAULT_CUBIT] Triggering HomeCubit refresh...', tag: 'Resume');
        getIt<HomeCubit>().refreshHomeData();
      } catch (e) {
        AppLogger.error('🔵 [RESUME_VAULT_CUBIT] Failed to trigger HomeCubit refresh: $e', tag: 'Resume', error: e);
      }
    } catch (e, stackTrace) {
      AppLogger.error('🔴 [RESUME_VAULT_CUBIT]', tag: 'Resume', error: e, stackTrace: stackTrace);
      if (!isClosed) {
        emit(
          state.copyWith(
            status: ResumeVaultStatus.failure,
            errorMessage: 'Failed to upload resume: $e',
          ),
        );
      }
    }
  }

  /// Reset the cubit state (for logout/session change)
  void reset() {
    AppLogger.debug('[RESUME_VAULT_CUBIT] Resetting resume data...', tag: 'Resume');
    _isInitialized = false;
    if (!isClosed) {
      emit(const ResumeVaultState());
    }
  }
}

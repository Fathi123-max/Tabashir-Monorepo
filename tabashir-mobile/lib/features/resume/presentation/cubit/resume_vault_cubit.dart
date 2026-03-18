import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/features/resume/domain/repositories/resume_vault_repository.dart';

part 'resume_vault_state.dart';
part 'resume_vault_cubit.freezed.dart';

@lazySingleton
class ResumeVaultCubit extends Cubit<ResumeVaultState> {
  ResumeVaultCubit(this._repository) : super(const ResumeVaultState()) {
    // Removed auto-load - resumes will be loaded when needed
    print('🔵 [RESUME_VAULT_CUBIT] Cubit created (no auto-load)');
  }

  final ResumeVaultRepository _repository;
  bool _isLoading = false;
  bool _isInitialized = false; // Track initialization state

  /// Initialize resumes (called once, typically from AppInitializationCubit)
  Future<void> initializeWithResumes(List<ResumeItem> resumes) async {
    if (_isInitialized) {
      print('🔵 [RESUME_VAULT_CUBIT] Already initialized, skipping');
      return;
    }

    print(
      '🔵 [RESUME_VAULT_CUBIT] Initializing with ${resumes.length} resumes from shared data',
    );
    emit(
      state.copyWith(
        status: ResumeVaultStatus.success,
        resumes: resumes,
      ),
    );
    _isInitialized = true;
    print(
      '🔵 [RESUME_VAULT_CUBIT] ✅ Resume vault initialized with shared data',
    );
  }

  Future<void> loadResumes({bool force = false}) async {
    // Prevent duplicate concurrent loads
    if (_isLoading && !force) {
      print('🔵 [RESUME_VAULT_CUBIT] Already loading, skipping duplicate call');
      return;
    }

    // Skip if already loaded and not forced
    if (!force &&
        state.status == ResumeVaultStatus.success &&
        state.resumes.isNotEmpty) {
      print('🔵 [RESUME_VAULT_CUBIT] Already loaded, skipping');
      return;
    }

    // If not initialized yet, don't auto-load - wait for initializeWithResumes
    if (!_isInitialized && !force) {
      print(
        '🔵 [RESUME_VAULT_CUBIT] Not initialized yet, skipping auto-load. Call initializeWithResumes() first.',
      );
      return;
    }

    _isLoading = true;
    print('🔵 [RESUME_VAULT_CUBIT] loadResumes() called');
    print('🔵 [RESUME_VAULT_CUBIT] Current state: ${state.status}');
    emit(state.copyWith(status: ResumeVaultStatus.loading));
    print('🔵 [RESUME_VAULT_CUBIT] Emitted loading state');

    try {
      print('🔵 [RESUME_VAULT_CUBIT] Fetching resumes from repository...');
      final resumes = await _repository.getUserResumes();
      print(
        '🔵 [RESUME_VAULT_CUBIT] ✅ Fetched ${resumes.length} resumes from repository',
      );
      print(
        '🔵 [RESUME_VAULT_CUBIT] Resume IDs: ${resumes.map((r) => r.id).join(', ')}',
      );

      emit(
        state.copyWith(
          status: ResumeVaultStatus.success,
          resumes: resumes,
        ),
      );
      print(
        '🔵 [RESUME_VAULT_CUBIT] ✅ Emitted success state with ${resumes.length} resumes',
      );
    } catch (e, stackTrace) {
      print('🔴 [RESUME_VAULT_CUBIT] ❌ Error loading resumes: $e');
      print('🔴 [RESUME_VAULT_CUBIT] StackTrace: $stackTrace');
      emit(
        state.copyWith(
          status: ResumeVaultStatus.failure,
          errorMessage: e.toString(),
        ),
      );
      print('🔵 [RESUME_VAULT_CUBIT] Emitted failure state');
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteResume(String id) async {
    print('🔵 [RESUME_VAULT_CUBIT] deleteResume() called for ID: $id');
    emit(state.copyWith(status: ResumeVaultStatus.deleting));

    try {
      await _repository.deleteResume(resumeId: id);
      print('🔵 [RESUME_VAULT_CUBIT] ✅ Repository delete successful');

      final updatedResumes = state.resumes
          .where((ResumeItem r) => r.id != id)
          .toList();
      print(
        '🔵 [RESUME_VAULT_CUBIT] Updated resumes count: ${updatedResumes.length}',
      );

      emit(
        state.copyWith(
          resumes: updatedResumes,
          status: ResumeVaultStatus.success,
        ),
      );
      print('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted success state after delete');
    } catch (e, stackTrace) {
      print('🔴 [RESUME_VAULT_CUBIT] ❌ Error deleting resume: $e');
      print('🔴 [RESUME_VAULT_CUBIT] StackTrace: $stackTrace');
      emit(
        state.copyWith(
          status: ResumeVaultStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> setDefaultResume(String id) async {
    print('🔵 [RESUME_VAULT_CUBIT] setDefaultResume() called for ID: $id');
    try {
      await _repository.setDefaultResume(resumeId: id);
      print('🔵 [RESUME_VAULT_CUBIT] ✅ Repository setDefault successful');

      final updatedResumes = state.resumes
          .map(
            (ResumeItem resume) => resume.copyWith(isDefault: resume.id == id),
          )
          .toList();

      emit(state.copyWith(resumes: updatedResumes));
      print('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted state with updated default');
    } catch (e, stackTrace) {
      print('🔴 [RESUME_VAULT_CUBIT] ❌ Error setting default: $e');
      print('🔴 [RESUME_VAULT_CUBIT] StackTrace: $stackTrace');
      emit(
        state.copyWith(
          status: ResumeVaultStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> duplicateResume(String id) async {
    print('🔵 [RESUME_VAULT_CUBIT] duplicateResume() called for ID: $id');
    try {
      final duplicatedResume = await _repository.duplicateResume(resumeId: id);
      print(
        '🔵 [RESUME_VAULT_CUBIT] ✅ Duplicated resume: ${duplicatedResume.id}',
      );

      final updatedResumes = [duplicatedResume, ...state.resumes];
      print(
        '🔵 [RESUME_VAULT_CUBIT] Total resumes after duplicate: ${updatedResumes.length}',
      );

      emit(state.copyWith(resumes: updatedResumes));
      print('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted state with duplicated resume');
    } catch (e, stackTrace) {
      print('🔴 [RESUME_VAULT_CUBIT] ❌ Error duplicating: $e');
      print('🔴 [RESUME_VAULT_CUBIT] StackTrace: $stackTrace');
      emit(
        state.copyWith(
          status: ResumeVaultStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> renameResume(String id, String newName) async {
    print(
      '🔵 [RESUME_VAULT_CUBIT] renameResume() called for ID: $id to name: $newName',
    );
    try {
      final updatedResume = await _repository.renameResume(
        resumeId: id,
        newName: newName,
      );
      print(
        '🔵 [RESUME_VAULT_CUBIT] ✅ Renamed resume to: ${updatedResume.name}',
      );

      final updatedResumes = state.resumes.map((ResumeItem resume) {
        if (resume.id == id) {
          return updatedResume;
        }
        return resume;
      }).toList();

      emit(state.copyWith(resumes: updatedResumes));
      print('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted state with renamed resume');
    } catch (e, stackTrace) {
      print('🔴 [RESUME_VAULT_CUBIT] ❌ Error renaming: $e');
      print('🔴 [RESUME_VAULT_CUBIT] StackTrace: $stackTrace');
      emit(
        state.copyWith(
          status: ResumeVaultStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> uploadResume({
    required String fileName,
    required String filePath,
    required String fileType,
    required int fileSize,
  }) async {
    print('🔵 [RESUME_VAULT_CUBIT] uploadResume() called');
    print(
      '🔵 [RESUME_VAULT_CUBIT] File: $fileName, Path: $filePath, Size: $fileSize bytes',
    );
    emit(state.copyWith(status: ResumeVaultStatus.uploading));

    try {
      final newResume = await _repository.uploadResume(
        fileName: fileName,
        filePath: filePath,
        fileType: fileType,
        fileSize: fileSize,
      );
      print('🔵 [RESUME_VAULT_CUBIT] ✅ Uploaded resume: ${newResume.id}');

      final updatedResumes = [newResume, ...state.resumes];
      print(
        '🔵 [RESUME_VAULT_CUBIT] Total resumes after upload: ${updatedResumes.length}',
      );

      emit(
        state.copyWith(
          status: ResumeVaultStatus.success,
          resumes: updatedResumes,
        ),
      );
      print('🔵 [RESUME_VAULT_CUBIT] ✅ Emitted success state with new resume');
    } catch (e, stackTrace) {
      print('🔴 [RESUME_VAULT_CUBIT] ❌ Error uploading: $e');
      print('🔴 [RESUME_VAULT_CUBIT] StackTrace: $stackTrace');
      emit(
        state.copyWith(
          status: ResumeVaultStatus.failure,
          errorMessage: 'Failed to upload resume: $e',
        ),
      );
    }
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/resume/domain/repositories/resume_vault_repository.dart';
import 'package:tabashir/features/resume/services/resume_parsing_service.dart';
import 'package:tabashir/core/utils/app_logger.dart';

part 'resume_import_state.dart';
part 'resume_import_cubit.freezed.dart';

@Injectable()
class ResumeImportCubit extends Cubit<ResumeImportState> {
  ResumeImportCubit(
    this._resumeParsingService,
    this._resumeVaultRepository,
  ) : super(const ResumeImportState.initial());
  final ResumeParsingService _resumeParsingService;
  final ResumeVaultRepository _resumeVaultRepository;

  Future<void> pickResumeFile() async {
    AppLogger.debug('\n🔵 [RESUME_IMPORT] === pickResumeFile() STARTED ===', tag: 'Resume');

    // Check if user is authenticated before proceeding
    final isAuthenticated = await AuthSessionService.instance.isAuthenticated;
    if (!isAuthenticated) {
      AppLogger.debug('🔴 [RESUME_IMPORT] User not authenticated - cannot upload resume', tag: 'Resume');
      emit(
        const ResumeImportState.error(
          'Authentication required. Please complete sign up/login first, then try importing your resume again.',
        ),
      );
      return;
    }

    emit(const ResumeImportState.loading());
    AppLogger.debug('🔵 [RESUME_IMPORT] Emitted loading state', tag: 'Resume');

    try {
      AppLogger.debug('🔵 [RESUME_IMPORT] Opening file picker...', tag: 'Resume');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      AppLogger.debug('🔵 [RESUME_IMPORT] File picker returned: ${result != null ? 'files selected' : 'user cancelled'}', tag: 'Resume');

      if (result != null) {
        AppLogger.debug('🔵 [RESUME_IMPORT] Files selected: ${result.files.length}', tag: 'Resume');
        final file = result.files.single;
        AppLogger.debug('🔵 [RESUME_IMPORT] Selected file details:', tag: 'Resume');
        AppLogger.debug('  - Name: ${file.name}', tag: 'Resume');
        AppLogger.debug('  - Path: ${file.path}', tag: 'Resume');
        AppLogger.debug('  - Size: ${file.size} bytes', tag: 'Resume');
        AppLogger.debug('  - Extension: ${file.extension}', tag: 'Resume');

        if (file.path == null) {
          AppLogger.debug('🔴 [RESUME_IMPORT] File path is null', tag: 'Resume');
          emit(const ResumeImportState.error('File path is invalid'));
          return;
        }

        // Validate file exists
        AppLogger.debug('🔵 [RESUME_IMPORT] Checking if file exists at path...', tag: 'Resume');
        final resumeFile = File(file.path!);
        final fileExists = await resumeFile.exists();
        AppLogger.debug('🔵 [RESUME_IMPORT] File exists: $fileExists', tag: 'Resume');

        if (fileExists) {
          AppLogger.debug('🔵 [RESUME_IMPORT] File confirmed, calling _uploadResume()', tag: 'Resume');
          await _uploadResume(
            fileName: file.name,
            filePath: file.path!,
            fileType: file.extension?.toLowerCase() ?? '',
            fileSize: file.size,
          );
          AppLogger.debug('🔵 [RESUME_IMPORT] _uploadResume() completed', tag: 'Resume');
        } else {
          AppLogger.debug('🔴 [RESUME_IMPORT] ERROR: File does not exist at path: ${file.path}', tag: 'Resume');
          emit(const ResumeImportState.error('Selected file not found'));
        }
      } else {
        AppLogger.debug('🔵 [RESUME_IMPORT] User cancelled file selection', tag: 'Resume');
        AppLogger.debug('🔵 [RESUME_IMPORT] Emitting initial state', tag: 'Resume');
        emit(const ResumeImportState.initial());
      }
    } catch (e, stackTrace) {
      AppLogger.debug('🔴 [RESUME_IMPORT] EXCEPTION occurred in pickResumeFile():', tag: 'Resume');
      AppLogger.error('🔴 [RESUME_IMPORT]', tag: 'Resume', error: e, stackTrace: stackTrace);
      emit(ResumeImportState.error(e.toString()));
    }
    AppLogger.debug('🔵 [RESUME_IMPORT] === pickResumeFile() COMPLETED ===\n', tag: 'Resume');
  }

  Future<void> importFromCloud() async {
    // TODO: Implement cloud import (Google Drive, Dropbox, etc.)
    emit(const ResumeImportState.error('Cloud import not implemented yet'));
  }

  Future<void> pasteResumeText(String resumeText) async {
    AppLogger.debug('\n🔵 [RESUME_IMPORT] === pasteResumeText() STARTED ===', tag: 'Resume');

    // Check if user is authenticated before proceeding
    final isAuthenticated = await AuthSessionService.instance.isAuthenticated;
    if (!isAuthenticated) {
      AppLogger.debug('🔴 [RESUME_IMPORT] User not authenticated - cannot process resume text', tag: 'Resume');
      emit(
        const ResumeImportState.error(
          'Authentication required. Please complete sign up/login first, then try importing your resume again.',
        ),
      );
      return;
    }

    AppLogger.debug('🔵 [RESUME_IMPORT] Text length: ${resumeText.length} characters', tag: 'Resume');

    if (resumeText.trim().isEmpty) {
      AppLogger.debug('🔴 [RESUME_IMPORT] ERROR: Resume text is empty', tag: 'Resume');
      emit(const ResumeImportState.error('Resume text cannot be empty'));
      return;
    }

    emit(const ResumeImportState.loading());
    AppLogger.debug('🔵 [RESUME_IMPORT] Emitted loading state', tag: 'Resume');

    try {
      AppLogger.debug('🔵 [RESUME_IMPORT] Processing pasted text with resume parsing service...', tag: 'Resume');
      final parsedData = await _resumeParsingService.parseResumeFromText(
        resumeText,
      );
      AppLogger.debug('🟢 [RESUME_IMPORT] ✅ Resume text parsed successfully', tag: 'Resume');
      AppLogger.debug('🟢 [RESUME_IMPORT] Parsed data: $parsedData', tag: 'Resume');

      AppLogger.debug('🔵 [RESUME_IMPORT] Emitting success state', tag: 'Resume');
      emit(const ResumeImportState.success());
      AppLogger.debug('🟢 [RESUME_IMPORT] ✅ Successfully emitted success state', tag: 'Resume');
    } catch (e, stackTrace) {
      AppLogger.error('\n🔴 [RESUME_IMPORT]', tag: 'Resume', error: e, stackTrace: stackTrace);

      emit(ResumeImportState.error(e.toString()));
      AppLogger.error('🔴 [RESUME_IMPORT] Error state emitted', tag: 'Resume');
    }
    AppLogger.debug('\n🔵 [RESUME_IMPORT] === pasteResumeText() COMPLETED ===\n', tag: 'Resume');
  }

  Future<void> _uploadResume({
    required String fileName,
    required String filePath,
    required String fileType,
    required int fileSize,
  }) async {
    AppLogger.debug('\n🟡 [RESUME_IMPORT] === _uploadResume() STARTED ===', tag: 'Resume');
    AppLogger.debug('🟡 [RESUME_IMPORT] Parameters:', tag: 'Resume');
    AppLogger.debug('  - fileName: $fileName', tag: 'Resume');
    AppLogger.debug('  - filePath: $filePath', tag: 'Resume');
    AppLogger.debug('  - fileType: $fileType', tag: 'Resume');
    AppLogger.debug('  - fileSize: $fileSize bytes', tag: 'Resume');

    emit(const ResumeImportState.loading());
    AppLogger.debug('🟡 [RESUME_IMPORT] Emitted loading state', tag: 'Resume');

    try {
      AppLogger.debug('🟡 [RESUME_IMPORT] Extracting structured data before upload...', tag: 'Resume');
      Map<String, dynamic>? parsedData;
      try {
        parsedData = await _resumeParsingService.parseResumeFile(
          File(filePath),
          fileName,
        );
        AppLogger.debug('🟢 [RESUME_IMPORT] Local parsing completed.', tag: 'Resume');
      } catch (e) {
        AppLogger.error('⚠️ [RESUME_IMPORT] Local parsing failed, will continue without parsed data. Error: $e', tag: 'Resume', error: e);
      }

      AppLogger.debug('🟡 [RESUME_IMPORT] Uploading resume to backend API...', tag: 'Resume');

      final result = await _resumeVaultRepository.uploadResume(
        fileName: fileName,
        filePath: filePath,
        fileType: fileType,
        fileSize: fileSize,
      );

      AppLogger.debug('🟢 [RESUME_IMPORT] ✅ uploadResume() completed', tag: 'Resume');
      AppLogger.debug('🟢 [RESUME_IMPORT] Upload result ID: ${result.id}', tag: 'Resume');

      // Trigger dashboard refresh via HomeCubit to show new profile data
      try {
        AppLogger.debug('🟡 [RESUME_IMPORT] Triggering HomeCubit refresh...', tag: 'Resume');
        await getIt<HomeCubit>().refreshHomeData();
      } catch (e) {
        AppLogger.error('🔴 [RESUME_IMPORT] Failed to trigger HomeCubit refresh: $e', tag: 'Resume', error: e);
      }

      // Emit success state
      AppLogger.debug('🟡 [RESUME_IMPORT] Emitting success state', tag: 'Resume');
      emit(
        ResumeImportState.success(
          resume: result,
          parsedData: parsedData,
        ),
      );
      AppLogger.debug('🟢 [RESUME_IMPORT] ✅ Successfully emitted success state', tag: 'Resume');
    } catch (e, stackTrace) {
      AppLogger.error('\n🔴 [RESUME_IMPORT] ❌ Upload failed: $e', tag: 'Resume', error: e);
      AppLogger.debug('🔴 [RESUME_IMPORT] StackTrace: $stackTrace', tag: 'Resume');

      // Check if this is an authentication error
      final errorMessage = e.toString();
      if (errorMessage.contains('401') ||
          errorMessage.toLowerCase().contains('unauthorized')) {
        AppLogger.error('🟡 [RESUME_IMPORT] Authentication error - user might not be logged in yet', tag: 'Resume');
        emit(
          const ResumeImportState.error(
            'Authentication required. Please complete sign up/login first, then try importing your resume again.',
          ),
        );
      } else {
        AppLogger.error('\n🔴 [RESUME_IMPORT] Emitting error state...', tag: 'Resume');
        emit(ResumeImportState.error(e.toString()));
      }
      AppLogger.error('🔴 [RESUME_IMPORT] Error state emitted', tag: 'Resume');
    }
    AppLogger.debug('\n🟡 [RESUME_IMPORT] === _uploadResume() COMPLETED ===\n', tag: 'Resume');
  }

  void skipForNow() {
    emit(const ResumeImportState.skipped());
  }
}

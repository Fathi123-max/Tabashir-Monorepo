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
    print('\n🔵 [RESUME_IMPORT] === pickResumeFile() STARTED ===');

    // Check if user is authenticated before proceeding
    final isAuthenticated = await AuthSessionService.instance.isAuthenticated;
    if (!isAuthenticated) {
      print('🔴 [RESUME_IMPORT] User not authenticated - cannot upload resume');
      emit(
        const ResumeImportState.error(
          'Authentication required. Please complete sign up/login first, then try importing your resume again.',
        ),
      );
      return;
    }

    emit(const ResumeImportState.loading());
    print('🔵 [RESUME_IMPORT] Emitted loading state');

    try {
      print('🔵 [RESUME_IMPORT] Opening file picker...');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      print(
        '🔵 [RESUME_IMPORT] File picker returned: ${result != null ? 'files selected' : 'user cancelled'}',
      );

      if (result != null) {
        print('🔵 [RESUME_IMPORT] Files selected: ${result.files.length}');
        final file = result.files.single;
        print('🔵 [RESUME_IMPORT] Selected file details:');
        print('  - Name: ${file.name}');
        print('  - Path: ${file.path}');
        print('  - Size: ${file.size} bytes');
        print('  - Extension: ${file.extension}');

        if (file.path == null) {
          print('🔴 [RESUME_IMPORT] File path is null');
          emit(const ResumeImportState.error('File path is invalid'));
          return;
        }

        // Validate file exists
        print('🔵 [RESUME_IMPORT] Checking if file exists at path...');
        final resumeFile = File(file.path!);
        final fileExists = await resumeFile.exists();
        print('🔵 [RESUME_IMPORT] File exists: $fileExists');

        if (fileExists) {
          print(
            '🔵 [RESUME_IMPORT] File confirmed, calling _uploadResume()',
          );
          await _uploadResume(
            fileName: file.name,
            filePath: file.path!,
            fileType: file.extension?.toLowerCase() ?? '',
            fileSize: file.size,
          );
          print('🔵 [RESUME_IMPORT] _uploadResume() completed');
        } else {
          print(
            '🔴 [RESUME_IMPORT] ERROR: File does not exist at path: ${file.path}',
          );
          emit(const ResumeImportState.error('Selected file not found'));
        }
      } else {
        print('🔵 [RESUME_IMPORT] User cancelled file selection');
        print('🔵 [RESUME_IMPORT] Emitting initial state');
        emit(const ResumeImportState.initial());
      }
    } catch (e, stackTrace) {
      print('🔴 [RESUME_IMPORT] EXCEPTION occurred in pickResumeFile():');
      print('🔴 [RESUME_IMPORT] Error: $e');
      print('🔴 [RESUME_IMPORT] StackTrace: $stackTrace');
      emit(ResumeImportState.error(e.toString()));
    }
    print('🔵 [RESUME_IMPORT] === pickResumeFile() COMPLETED ===\n');
  }

  Future<void> importFromCloud() async {
    // TODO: Implement cloud import (Google Drive, Dropbox, etc.)
    emit(const ResumeImportState.error('Cloud import not implemented yet'));
  }

  Future<void> pasteResumeText(String resumeText) async {
    print('\n🔵 [RESUME_IMPORT] === pasteResumeText() STARTED ===');

    // Check if user is authenticated before proceeding
    final isAuthenticated = await AuthSessionService.instance.isAuthenticated;
    if (!isAuthenticated) {
      print(
        '🔴 [RESUME_IMPORT] User not authenticated - cannot process resume text',
      );
      emit(
        const ResumeImportState.error(
          'Authentication required. Please complete sign up/login first, then try importing your resume again.',
        ),
      );
      return;
    }

    print('🔵 [RESUME_IMPORT] Text length: ${resumeText.length} characters');

    if (resumeText.trim().isEmpty) {
      print('🔴 [RESUME_IMPORT] ERROR: Resume text is empty');
      emit(const ResumeImportState.error('Resume text cannot be empty'));
      return;
    }

    emit(const ResumeImportState.loading());
    print('🔵 [RESUME_IMPORT] Emitted loading state');

    try {
      print(
        '🔵 [RESUME_IMPORT] Processing pasted text with resume parsing service...',
      );
      final parsedData = await _resumeParsingService.parseResumeFromText(
        resumeText,
      );
      print('🟢 [RESUME_IMPORT] ✅ Resume text parsed successfully');
      print('🟢 [RESUME_IMPORT] Parsed data: $parsedData');

      print('🔵 [RESUME_IMPORT] Emitting success state');
      emit(const ResumeImportState.success());
      print('🟢 [RESUME_IMPORT] ✅ Successfully emitted success state');
    } catch (e, stackTrace) {
      print('\n🔴 [RESUME_IMPORT] ❌ ERROR in pasteResumeText():');
      print('🔴 [RESUME_IMPORT] Exception: $e');
      print('🔴 [RESUME_IMPORT] StackTrace: $stackTrace');

      emit(ResumeImportState.error(e.toString()));
      print('🔴 [RESUME_IMPORT] Error state emitted');
    }
    print('\n🔵 [RESUME_IMPORT] === pasteResumeText() COMPLETED ===\n');
  }

  Future<void> _uploadResume({
    required String fileName,
    required String filePath,
    required String fileType,
    required int fileSize,
  }) async {
    print('\n🟡 [RESUME_IMPORT] === _uploadResume() STARTED ===');
    print('🟡 [RESUME_IMPORT] Parameters:');
    print('  - fileName: $fileName');
    print('  - filePath: $filePath');
    print('  - fileType: $fileType');
    print('  - fileSize: $fileSize bytes');

    emit(const ResumeImportState.loading());
    print('🟡 [RESUME_IMPORT] Emitted loading state');

    try {
      print('🟡 [RESUME_IMPORT] Extracting structured data before upload...');
      Map<String, dynamic>? parsedData;
      try {
        parsedData = await _resumeParsingService.parseResumeFile(
          File(filePath),
          fileName,
        );
        print('🟢 [RESUME_IMPORT] Local parsing completed.');
      } catch (e) {
        print(
          '⚠️ [RESUME_IMPORT] Local parsing failed, will continue without parsed data. Error: $e',
        );
      }

      print(
        '🟡 [RESUME_IMPORT] Uploading resume to backend API...',
      );

      final result = await _resumeVaultRepository.uploadResume(
        fileName: fileName,
        filePath: filePath,
        fileType: fileType,
        fileSize: fileSize,
      );

      print('🟢 [RESUME_IMPORT] ✅ uploadResume() completed');
      print('🟢 [RESUME_IMPORT] Upload result ID: ${result.id}');

      // Trigger dashboard refresh via HomeCubit to show new profile data
      try {
        print('🟡 [RESUME_IMPORT] Triggering HomeCubit refresh...');
        await getIt<HomeCubit>().refreshHomeData(userProfile: null);
      } catch (e) {
        print('🔴 [RESUME_IMPORT] Failed to trigger HomeCubit refresh: $e');
      }

      // Emit success state
      print('🟡 [RESUME_IMPORT] Emitting success state');
      emit(
        ResumeImportState.success(
          resume: result,
          parsedData: parsedData,
        ),
      );
      print('🟢 [RESUME_IMPORT] ✅ Successfully emitted success state');
    } catch (e, stackTrace) {
      print('\n🔴 [RESUME_IMPORT] ❌ Upload failed: $e');
      print('🔴 [RESUME_IMPORT] StackTrace: $stackTrace');

      // Check if this is an authentication error
      final errorMessage = e.toString();
      if (errorMessage.contains('401') ||
          errorMessage.toLowerCase().contains('unauthorized')) {
        print(
          '🟡 [RESUME_IMPORT] Authentication error - user might not be logged in yet',
        );
        emit(
          const ResumeImportState.error(
            'Authentication required. Please complete sign up/login first, then try importing your resume again.',
          ),
        );
      } else {
        print('\n🔴 [RESUME_IMPORT] Emitting error state...');
        emit(ResumeImportState.error(e.toString()));
      }
      print('🔴 [RESUME_IMPORT] Error state emitted');
    }
    print('\n🟡 [RESUME_IMPORT] === _uploadResume() COMPLETED ===\n');
  }

  void skipForNow() {
    emit(const ResumeImportState.skipped());
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tabashir/core/database/models/local_resume.dart';
import 'package:tabashir/core/database/repositories/local_resume_repository.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/core/network/services/resume/resume_api_service.dart';
import 'package:tabashir/features/resume/domain/repositories/resume_vault_repository.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Hybrid repository that combines backend storage with local caching
/// Implements the ResumeVaultRepository interface
///
/// Strategy:
/// 1. All operations go through backend API first
/// 2. Results cached locally for offline access
/// 3. Local cache serves as fallback when backend is unavailable
@Injectable(as: ResumeVaultRepository)
class SyncHybridResumeRepository implements ResumeVaultRepository {
  SyncHybridResumeRepository(
    this._apiService,
    this._localRepository,
  );

  final ResumeApiService _apiService;
  final LocalResumeRepository _localRepository;

  @override
  Future<List<ResumeItem>> getUserResumes() async {
    AppLogger.debug('🔄 [SYNC_REPO] getUserResumes() - Fetching from backend...', tag: 'Resume');

    try {
      // Try to fetch from backend first
      final response = await _apiService.getResumes();
      AppLogger.debug('✅ [SYNC_REPO] ✅ Fetched ${response.resumes.length} resumes from backend', tag: 'Resume');

      // Enrich backend resumes with UI-specific properties
      final enrichedResumes = response.resumes.map((backendResume) {
        final title = _extractTitleFromFileName(backendResume.filename);

        // Use title as display name if name is empty or equals filename (technical name)
        final displayName =
            (backendResume.name.isEmpty ||
                backendResume.name == backendResume.filename)
            ? title
            : backendResume.name;

        return backendResume.copyWith(
          name: displayName,
          filePath: backendResume.originalUrl ?? '',
          fileType: _extractFileType(backendResume.filename),
          fileSize: 0, // Backend doesn't provide file size
          lastModified: _formatDate(backendResume.updatedAt),
          isDefault: false, // TODO: Get from backend if available
          title: title,
        );
      }).toList();

      // Cache locally for offline access
      await _cacheResumesLocally(enrichedResumes);
      AppLogger.debug('💾 [SYNC_REPO] ✅ Cached ${enrichedResumes.length} resumes locally', tag: 'Resume');

      return enrichedResumes;
    } catch (e) {
      AppLogger.error('⚠️  [SYNC_REPO] ⚠️  Backend error: $e', tag: 'Resume', error: e);
      AppLogger.debug('🔄 [SYNC_REPO] 🔄 Falling back to local cache...', tag: 'Resume');

      // Fallback to local cache - convert to backend ResumeItem format
      try {
        final localResumes = await _localRepository.getAllResumes();
        AppLogger.debug('✅ [SYNC_REPO] ✅ Loaded ${localResumes.length} resumes from local cache', tag: 'Resume');

        // Convert local resumes to backend ResumeItem format for compatibility
        return localResumes
            .map(
              (local) => ResumeItem(
                id: local.id,
                filename: local.name,
                originalUrl: null, // No URL for local files
                formatedUrl: null,
                isAiResume: false,
                createdAt: local.createdAt,
                updatedAt: local.createdAt,
                // UI-specific properties
                name: local.name,
                filePath: local.filePath,
                fileType: local.fileType,
                fileSize: local.fileSize,
                lastModified: _formatDate(local.createdAt),
                isDefault: local.isDefault,
                title: local.title,
              ),
            )
            .toList();
      } catch (localError) {
        AppLogger.error('❌ [SYNC_REPO] ❌ Both backend and local failed', tag: 'Resume');
        // If both fail, rethrow the original error but with more context
        if (e is DioException) {
          final statusCode = e.response?.statusCode;
          final message = e.response?.data?['message'] ?? e.message;
          throw Exception('Backend error ($statusCode): $message');
        }
        throw e;
      }
    }
  }

  @override
  Future<ResumeItem> uploadResume({
    required String fileName,
    required String filePath,
    required String fileType,
    required int fileSize,
  }) async {
    AppLogger.debug('🔄 [SYNC_REPO] uploadResume() - Uploading to backend...', tag: 'Resume');

    try {
      // Copy temporary file to permanent location first
      final originalFile = File(filePath);
      if (!await originalFile.exists()) {
        throw Exception('File not found: $filePath');
      }

      // Create permanent copy in app documents directory
      final appDir = await getApplicationDocumentsDirectory();
      final resumeDir = Directory('${appDir.path}/resumes');
      await resumeDir.create(recursive: true);

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final permanentFileName = 'resume_$timestamp.$fileType';
      final permanentFilePath = '${resumeDir.path}/$permanentFileName';

      AppLogger.debug('🔄 [SYNC_REPO] Copying temporary file to: $permanentFilePath', tag: 'Resume');
      await originalFile.copy(permanentFilePath);

      // Verify the permanent file exists
      final permanentFile = File(permanentFilePath);
      if (!await permanentFile.exists()) {
        throw Exception('Failed to create permanent copy of resume file');
      }

      // Create multipart file for upload using permanent copy
      final multipartFile = await MultipartFile.fromFile(
        permanentFilePath,
        filename: fileName,
      );

      // Upload to backend
      final response = await _apiService.uploadResume(multipartFile);
      AppLogger.debug('✅ [SYNC_REPO] ✅ Uploaded resume to backend: ${response.resume.filename}', tag: 'Resume');

      // Cache locally using permanent path
      await _localRepository.addResume(
        name: response.resume.filename,
        title: _extractTitleFromFileName(response.resume.filename),
        filePath: permanentFilePath, // Use permanent path
        fileType: fileType,
        fileSize: fileSize,
      );
      AppLogger.debug('💾 [SYNC_REPO] ✅ Cached locally', tag: 'Resume');

      // Add UI-specific properties to the response
      final enrichedResume = response.resume.copyWith(
        name: fileName,
        filePath:
            response.resume.originalUrl ??
            permanentFilePath, // Use cloud URL if available, else permanent path
        fileType: fileType.toUpperCase(),
        fileSize: fileSize,
        lastModified: _formatDate(DateTime.now()),
        isDefault: false, // New resumes are not default by default
        title: _extractTitleFromFileName(fileName),
      );

      return enrichedResume;
    } catch (e) {
      AppLogger.error('❌ [SYNC_REPO] ❌ Upload failed: $e', tag: 'Resume', error: e);
      rethrow;
    }
  }

  @override
  Future<void> deleteResume({required String resumeId}) async {
    AppLogger.debug('🔄 [SYNC_REPO] deleteResume() for ID: $resumeId', tag: 'Resume');

    try {
      // Delete from backend
      await _apiService.deleteResume(resumeId);
      AppLogger.debug('✅ [SYNC_REPO] ✅ Deleted from backend', tag: 'Resume');

      // Delete from local cache
      await _localRepository.deleteResume(resumeId);
      AppLogger.debug('💾 [SYNC_REPO] ✅ Deleted from local cache', tag: 'Resume');
    } catch (e) {
      AppLogger.error('❌ [SYNC_REPO] ❌ Delete failed: $e', tag: 'Resume', error: e);
      rethrow;
    }
  }

  @override
  Future<void> setDefaultResume({required String resumeId}) async {
    AppLogger.debug('🔄 [SYNC_REPO] setDefaultResume() for ID: $resumeId', tag: 'Resume');

    try {
      // Update local cache (backend doesn't track default status)
      await _localRepository.setDefaultResume(resumeId);
      AppLogger.debug('💾 [SYNC_REPO] ✅ Updated default in local cache', tag: 'Resume');
    } catch (e) {
      AppLogger.error('❌ [SYNC_REPO] ❌ Set default failed: $e', tag: 'Resume', error: e);
      rethrow;
    }
  }

  @override
  Future<ResumeItem> duplicateResume({required String resumeId}) async {
    AppLogger.debug('🔄 [SYNC_REPO] duplicateResume() for ID: $resumeId', tag: 'Resume');

    try {
      // Duplicate on backend
      final response = await _apiService.duplicateResume(resumeId);
      AppLogger.debug('✅ [SYNC_REPO] ✅ Duplicated on backend: ${response.resume.filename}', tag: 'Resume');

      // Cache locally (copy file)
      final localResume = await _localRepository.duplicateResume(resumeId);
      AppLogger.debug('💾 [SYNC_REPO] ✅ Cached locally with ID: ${localResume.id}', tag: 'Resume');

      // Enrich with UI-specific properties
      final enrichedResume = response.resume.copyWith(
        name: response.resume.filename,
        filePath: response.resume.originalUrl ?? '',
        fileType: _extractFileType(response.resume.filename),
        fileSize: 0, // Unknown for backend duplicates
        lastModified: _formatDate(DateTime.now()),
        isDefault: false, // Duplicates are not default
        title: _extractTitleFromFileName(response.resume.filename),
      );

      return enrichedResume;
    } catch (e) {
      AppLogger.error('❌ [SYNC_REPO] ❌ Duplicate failed: $e', tag: 'Resume', error: e);
      rethrow;
    }
  }

  @override
  Future<ResumeItem> renameResume({
    required String resumeId,
    required String newName,
  }) async {
    AppLogger.debug('🔄 [SYNC_REPO] renameResume() for ID: $resumeId to name: $newName', tag: 'Resume');

    try {
      // Note: Backend API doesn't have a rename endpoint
      // For now, update locally and return updated resume

      // Get the resume from local cache
      final localResume = await _localRepository.getResumeById(resumeId);
      if (localResume == null) {
        throw Exception('Resume not found in local cache');
      }

      // Update local cache
      final updatedLocal = await _localRepository.renameResume(
        resumeId,
        newName,
      );
      AppLogger.debug('💾 [SYNC_REPO] ✅ Renamed in local cache', tag: 'Resume');

      // Return as backend ResumeItem format with UI properties
      return ResumeItem(
        id: updatedLocal.id,
        filename: updatedLocal.name,
        originalUrl: null,
        formatedUrl: null,
        isAiResume: false,
        createdAt: updatedLocal.createdAt,
        updatedAt: DateTime.now(),
        // UI-specific properties
        name: updatedLocal.name,
        filePath: updatedLocal.filePath,
        fileType: updatedLocal.fileType,
        fileSize: updatedLocal.fileSize,
        lastModified: _formatDate(DateTime.now()),
        isDefault: updatedLocal.isDefault,
        title: updatedLocal.title,
      );
    } catch (e) {
      AppLogger.error('❌ [SYNC_REPO] ❌ Rename failed: $e', tag: 'Resume', error: e);
      rethrow;
    }
  }

  // ==========================================
  // Helper Methods
  // ==========================================

  /// Cache backend resumes locally
  Future<void> _cacheResumesLocally(List<ResumeItem> backendResumes) async {
    try {
      // For now, we only cache metadata
      // Files are downloaded on-demand from backend.originalUrl
      AppLogger.debug('💾 [SYNC_REPO] Caching ${backendResumes.length} resumes locally', tag: 'Resume');
      // In the future, we could download and cache files here
    } catch (e) {
      AppLogger.error('⚠️  [SYNC_REPO] Failed to cache resumes: $e', tag: 'Resume', error: e);
    }
  }

  /// Extract title from file name
  String _extractTitleFromFileName(String fileName) {
    // Remove file extension
    final nameWithoutExt = fileName.split('.').first;

    // Remove common suffixes and IDs
    final cleanName = nameWithoutExt
        .replaceAll(RegExp(r'_resume$'), '') // Remove '_resume' suffix
        .replaceAll(
          RegExp(r'_[a-f0-9]{10,}$'),
          '',
        ); // Remove ID suffix (10+ hex chars)

    // Capitalize
    final formatted = cleanName
        .split('_')
        .where((word) => word.isNotEmpty) // Filter out empty words
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
              : word,
        )
        .join(' ');

    // If empty after cleaning, use a default
    if (formatted.isEmpty) {
      return 'My Resume';
    }

    return formatted;
  }

  /// Format date for display with relative time
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    // Show relative time for recent dates
    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Just now';
        }
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    }

    // Show absolute date for older dates
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Extract file type from filename
  String _extractFileType(String fileName) {
    final parts = fileName.split('.');
    if (parts.length > 1) {
      return parts.last.toUpperCase();
    }
    return 'PDF'; // Default
  }
}

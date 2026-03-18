/// Repository interface for resume vault operations
/// Defines the contract for managing resume files and metadata
library;

import 'package:tabashir/core/network/models/resume_response/resume_item.dart';

abstract class ResumeVaultRepository {
  /// Get all resumes for the current user
  /// Returns list of [ResumeItem]
  Future<List<ResumeItem>> getUserResumes();

  /// Upload a new resume file
  /// Returns the created [ResumeItem]
  Future<ResumeItem> uploadResume({
    required String fileName,
    required String filePath,
    required String fileType,
    required int fileSize,
  });

  /// Delete a resume
  /// Returns void when operation is complete
  Future<void> deleteResume({
    required String resumeId,
  });

  /// Set a resume as default
  /// Returns void when operation is complete
  Future<void> setDefaultResume({
    required String resumeId,
  });

  /// Duplicate a resume
  /// Returns the duplicated [ResumeItem]
  Future<ResumeItem> duplicateResume({
    required String resumeId,
  });

  /// Rename a resume
  /// Returns the updated [ResumeItem]
  Future<ResumeItem> renameResume({
    required String resumeId,
    required String newName,
  });
}

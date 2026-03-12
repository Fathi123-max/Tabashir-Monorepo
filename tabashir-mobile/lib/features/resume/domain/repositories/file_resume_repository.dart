import 'dart:io';

import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/core/network/models/resume_response/resume_response.dart';

/// Repository interface for file-based resume operations
/// Handles PDF upload, download, and management via backend API
abstract class FileResumeRepository {
  /// List all resumes from backend
  Future<List<ResumeItem>> getAllResumes();

  /// Get resume by ID from backend
  Future<ResumeItem> getResume({
    required String resumeId,
  });

  /// Upload a new resume file
  /// Returns the created resume item
  Future<ResumeItem> uploadResume({
    required File file,
  });

  /// Update resume (re-upload file)
  Future<ResumeItem> updateResume({
    required String resumeId,
    required File file,
  });

  /// Delete a resume
  Future<void> deleteResume({
    required String resumeId,
  });

  /// Duplicate a resume
  Future<ResumeItem> duplicateResume({
    required String resumeId,
  });

  /// Export resume as PDF
  Future<String> exportResumeAsPdf({
    required String resumeId,
  });

  /// Export resume as Word document
  Future<String> exportResumeAsWord({
    required String resumeId,
  });

  /// Translate resume to another language
  Future<ResumeItem> translateResume({
    required String resumeId,
    required String targetLanguage,
  });
}

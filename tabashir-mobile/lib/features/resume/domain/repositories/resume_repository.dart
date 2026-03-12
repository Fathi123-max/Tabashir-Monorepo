import 'package:tabashir/features/resume/data/models/resume_model.dart';

/// Repository interface for resume operations
/// Defines the contract for resume data operations
abstract class ResumeRepository {
  /// Get resume by ID
  /// Returns [Resume]
  Future<Resume> getResume({
    required String resumeId,
  });

  /// Get all resumes for a user
  /// Returns list of [Resume]
  Future<List<Resume>> getUserResumes({
    required String userId,
  });

  /// Create a new resume
  /// Returns the created [Resume]
  Future<Resume> createResume({
    required Resume resume,
  });

  /// Update resume
  /// Returns the updated [Resume]
  Future<Resume> updateResume({
    required String resumeId,
    required Resume resume,
  });

  /// Delete resume
  /// Returns void when operation is complete
  Future<void> deleteResume({
    required String resumeId,
  });

  /// Duplicate resume
  /// Returns the duplicated [Resume]
  Future<Resume> duplicateResume({
    required String resumeId,
    String? newTitle,
  });

  /// Export resume to PDF
  /// Returns download URL or base64 data
  Future<String> exportResumeToPdf({
    required String resumeId,
  });

  /// Export resume to Word document
  /// Returns download URL or base64 data
  Future<String> exportResumeToWord({
    required String resumeId,
  });

  /// Translate resume to Arabic
  /// Returns download URL or translation data
  Future<String> translateResume({
    required String resumeId,
    required String targetLanguage,
  });

  /// Add work experience to resume
  /// Returns void when operation is complete
  Future<void> addWorkExperience({
    required String resumeId,
    required WorkExperience experience,
  });

  /// Update work experience
  /// Returns void when operation is complete
  Future<void> updateWorkExperience({
    required String resumeId,
    required int index,
    required WorkExperience experience,
  });

  /// Remove work experience
  /// Returns void when operation is complete
  Future<void> removeWorkExperience({
    required String resumeId,
    required int index,
  });

  /// Add education to resume
  /// Returns void when operation is complete
  Future<void> addEducation({
    required String resumeId,
    required Education education,
  });

  /// Update education
  /// Returns void when operation is complete
  Future<void> updateEducation({
    required String resumeId,
    required int index,
    required Education education,
  });

  /// Remove education
  /// Returns void when operation is complete
  Future<void> removeEducation({
    required String resumeId,
    required int index,
  });

  /// Add skill to resume
  /// Returns void when operation is complete
  Future<void> addSkill({
    required String resumeId,
    required Skill skill,
  });

  /// Update skill
  /// Returns void when operation is complete
  Future<void> updateSkill({
    required String resumeId,
    required int index,
    required Skill skill,
  });

  /// Remove skill
  /// Returns void when operation is complete
  Future<void> removeSkill({
    required String resumeId,
    required int index,
  });
}

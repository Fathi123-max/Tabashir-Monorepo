import 'dart:typed_data';

import 'package:tabashir/features/ai_job_apply/data/models/location_preference_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/personal_details_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/resume_selection_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/target_role_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/review_model.dart';
import 'package:tabashir/core/network/models/jobs_match_response.dart';

/// Repository interface for AI Job Apply operations
/// Defines the contract for AI job application data operations
abstract class AiJobApplyRepository {
  /// Apply to jobs using AI
  /// Returns [JobsMatchResponse] with matched jobs
  /// Accepts file as Uint8List to avoid HTTP dependencies in domain layer
  Future<JobsMatchResponse> applyToJobs({
    required String email,
    required Uint8List fileBytes,
    required String fileName,
    required List<String> positions,
    required List<String> locations,
    required String nationality,
    required String gender,
  });

  /// Get available resumes for selection
  /// Returns list of [ResumeSelectionModel]
  Future<List<ResumeSelectionModel>> getAvailableResumes({
    required String userId,
  });

  /// Save resume selection
  /// Returns the saved [ResumeSelectionModel]
  Future<ResumeSelectionModel> saveResumeSelection({
    required String userId,
    required ResumeSelectionModel resume,
  });

  /// Get location preferences
  /// Returns list of [LocationPreferenceModel]
  Future<List<LocationPreferenceModel>> getLocationPreferences({
    required String userId,
  });

  /// Save location preferences
  /// Returns void when operation is complete
  Future<void> saveLocationPreferences({
    required String userId,
    required List<LocationPreferenceModel> preferences,
  });

  /// Get personal details
  /// Returns [PersonalDetailsModel]
  Future<PersonalDetailsModel> getPersonalDetails({
    required String userId,
  });

  /// Save personal details
  /// Returns void when operation is complete
  Future<void> savePersonalDetails({
    required String userId,
    required PersonalDetailsModel details,
  });

  /// Get target roles
  /// Returns list of [TargetRoleModel]
  Future<List<TargetRoleModel>> getTargetRoles({
    required String userId,
  });

  /// Save target roles
  /// Returns void when operation is complete
  Future<void> saveTargetRoles({
    required String userId,
    required List<TargetRoleModel> roles,
  });

  /// Save review
  /// Returns void when operation is complete
  Future<void> saveReview({
    required ReviewModel review,
  });

  /// Delete resume selection
  /// Returns void when operation is complete
  Future<void> deleteResumeSelection({
    required String userId,
    required String resumeId,
  });

  /// Download resume from cloud URL
  /// Returns file bytes for cloud-stored resumes
  Future<Uint8List> downloadResumeFromCloud({
    required String resumeUrl,
  });

  /// Apply to a specific job using default resume
  /// Returns [JobsMatchResponse] with application result
  Future<JobsMatchResponse> applyToSpecificJob({
    required String jobId,
    required String email,
    required Uint8List fileBytes,
    required String fileName,
    String? nationality,
    String? gender,
  });
}

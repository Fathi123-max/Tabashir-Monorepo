import 'package:freezed_annotation/freezed_annotation.dart';

part 'candidate_repository.freezed.dart';
part 'candidate_repository.g.dart';

@freezed
sealed class CandidateProfile with _$CandidateProfile {
  const factory CandidateProfile({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String location,
    required List<String> skills,
    required String experienceLevel,
    @Default([]) List<String> resumeUrls,
    @Default([]) List<String> jobApplications,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _CandidateProfile;

  factory CandidateProfile.fromJson(Map<String, dynamic> json) =>
      _$CandidateProfileFromJson(json);
}

/// Repository interface for candidate operations
/// Defines the contract for candidate data operations
abstract class CandidateRepository {
  /// Get candidate profile by ID
  /// Returns [CandidateProfile]
  Future<CandidateProfile> getCandidateProfile({
    required String candidateId,
  });

  /// Create a new candidate profile
  /// Returns the created [CandidateProfile]
  Future<CandidateProfile> createCandidateProfile({
    required CandidateProfile profile,
  });

  /// Update candidate profile
  /// Returns the updated [CandidateProfile]
  Future<CandidateProfile> updateCandidateProfile({
    required String candidateId,
    required CandidateProfile profile,
  });

  /// Delete candidate profile
  /// Returns void when operation is complete
  Future<void> deleteCandidateProfile({
    required String candidateId,
  });

  /// Get all candidates (for admin/recruiter views)
  /// Returns list of [CandidateProfile]
  Future<List<CandidateProfile>> getAllCandidates();

  /// Search candidates by skills or location
  /// Returns list of [CandidateProfile]
  Future<List<CandidateProfile>> searchCandidates({
    required String query,
    String? location,
    String? experienceLevel,
  });

  /// Add a resume to candidate profile
  /// Returns void when operation is complete
  Future<void> addResume({
    required String candidateId,
    required String resumeUrl,
  });

  /// Remove a resume from candidate profile
  /// Returns void when operation is complete
  Future<void> removeResume({
    required String candidateId,
    required String resumeUrl,
  });

  /// Add a job application to candidate
  /// Returns void when operation is complete
  Future<void> addJobApplication({
    required String candidateId,
    required String jobId,
  });

  /// Remove a job application from candidate
  /// Returns void when operation is complete
  Future<void> removeJobApplication({
    required String candidateId,
    required String jobId,
  });
}

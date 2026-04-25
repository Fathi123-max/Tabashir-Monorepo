import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/local_persistence_service.dart';
import 'package:tabashir/features/candidate/domain/repositories/candidate_repository.dart';

/// Implementation of [CandidateRepository]
/// Handles candidate operations using [LocalPersistenceService] for local storage
@Injectable(as: CandidateRepository)
class CandidateRepositoryImpl implements CandidateRepository {
  CandidateRepositoryImpl(this._persistenceService);

  final LocalPersistenceService _persistenceService;

  @override
  Future<CandidateProfile> getCandidateProfile({
    required String candidateId,
  }) async {
    try {
      final prefs = _persistenceService.prefs;
      final profileJson = prefs.getString('candidate_profile_$candidateId');
      if (profileJson == null || profileJson.isEmpty) {
        throw Exception('Candidate profile not found');
      }

      final profile = jsonDecode(profileJson) as Map<String, dynamic>;
      return CandidateProfile.fromJson(profile);
    } catch (e) {
      throw Exception('Failed to get candidate profile: $e');
    }
  }

  @override
  Future<CandidateProfile> createCandidateProfile({
    required CandidateProfile profile,
  }) async {
    try {
      final prefs = _persistenceService.prefs;
      final profileJson = jsonEncode(profile.toJson());
      await prefs.setString('candidate_profile_${profile.id}', profileJson);

      // Also add to list of all candidates
      final allCandidatesJson = prefs.getString('all_candidates');
      final allCandidates = <String>[];

      if (allCandidatesJson != null && allCandidatesJson.isNotEmpty) {
        allCandidates.addAll(
          (jsonDecode(allCandidatesJson) as List<dynamic>).cast<String>(),
        );
      }

      if (!allCandidates.contains(profile.id)) {
        allCandidates.add(profile.id);
        final updatedJson = jsonEncode(allCandidates);
        await prefs.setString('all_candidates', updatedJson);
      }

      return profile;
    } catch (e) {
      throw Exception('Failed to create candidate profile: $e');
    }
  }

  @override
  Future<CandidateProfile> updateCandidateProfile({
    required String candidateId,
    required CandidateProfile profile,
  }) async {
    try {
      final prefs = _persistenceService.prefs;
      final profileJson = jsonEncode(profile.toJson());
      await prefs.setString('candidate_profile_$candidateId', profileJson);
      return profile;
    } catch (e) {
      throw Exception('Failed to update candidate profile: $e');
    }
  }

  @override
  Future<void> deleteCandidateProfile({
    required String candidateId,
  }) async {
    try {
      final prefs = _persistenceService.prefs;
      await prefs.remove('candidate_profile_$candidateId');

      // Remove from all candidates list
      final allCandidatesJson = prefs.getString('all_candidates');
      if (allCandidatesJson != null && allCandidatesJson.isNotEmpty) {
        final allCandidates = (jsonDecode(allCandidatesJson) as List<dynamic>)
            .cast<String>();
        allCandidates.remove(candidateId);
        final updatedJson = jsonEncode(allCandidates);
        await prefs.setString('all_candidates', updatedJson);
      }
    } catch (e) {
      throw Exception('Failed to delete candidate profile: $e');
    }
  }

  @override
  Future<List<CandidateProfile>> getAllCandidates() async {
    try {
      final prefs = _persistenceService.prefs;
      final allCandidatesJson = prefs.getString('all_candidates');
      if (allCandidatesJson == null || allCandidatesJson.isEmpty) {
        return <CandidateProfile>[];
      }

      final allCandidates = (jsonDecode(allCandidatesJson) as List<dynamic>)
          .cast<String>();
      final profiles = <CandidateProfile>[];

      for (final candidateId in allCandidates) {
        final profileJson = prefs.getString('candidate_profile_$candidateId');
        if (profileJson != null && profileJson.isNotEmpty) {
          final profile = jsonDecode(profileJson) as Map<String, dynamic>;
          profiles.add(CandidateProfile.fromJson(profile));
        }
      }

      return profiles;
    } catch (e) {
      throw Exception('Failed to get all candidates: $e');
    }
  }

  @override
  Future<List<CandidateProfile>> searchCandidates({
    required String query,
    String? location,
    String? experienceLevel,
  }) async {
    try {
      final allCandidates = await getAllCandidates();
      final lowerQuery = query.toLowerCase();

      return allCandidates.where((profile) {
        final matchesQuery =
            profile.name.toLowerCase().contains(lowerQuery) ||
            profile.skills.any(
              (skill) => skill.toLowerCase().contains(lowerQuery),
            ) ||
            profile.email.toLowerCase().contains(lowerQuery);

        final matchesLocation =
            location == null ||
            profile.location.toLowerCase().contains(location.toLowerCase());

        final matchesExperience =
            experienceLevel == null ||
            profile.experienceLevel == experienceLevel;

        return matchesQuery && matchesLocation && matchesExperience;
      }).toList();
    } catch (e) {
      throw Exception('Failed to search candidates: $e');
    }
  }

  @override
  Future<void> addResume({
    required String candidateId,
    required String resumeUrl,
  }) async {
    try {
      final profile = await getCandidateProfile(candidateId: candidateId);
      final updatedResumes = List<String>.from(profile.resumeUrls)
        ..add(resumeUrl);
      final updatedProfile = profile.copyWith(resumeUrls: updatedResumes);
      await updateCandidateProfile(
        candidateId: candidateId,
        profile: updatedProfile,
      );
    } catch (e) {
      throw Exception('Failed to add resume: $e');
    }
  }

  @override
  Future<void> removeResume({
    required String candidateId,
    required String resumeUrl,
  }) async {
    try {
      final profile = await getCandidateProfile(candidateId: candidateId);
      final updatedResumes = List<String>.from(profile.resumeUrls)
        ..removeWhere((url) => url == resumeUrl);
      final updatedProfile = profile.copyWith(resumeUrls: updatedResumes);
      await updateCandidateProfile(
        candidateId: candidateId,
        profile: updatedProfile,
      );
    } catch (e) {
      throw Exception('Failed to remove resume: $e');
    }
  }

  @override
  Future<void> addJobApplication({
    required String candidateId,
    required String jobId,
  }) async {
    try {
      final profile = await getCandidateProfile(candidateId: candidateId);
      final updatedApplications = List<String>.from(profile.jobApplications)
        ..add(jobId);
      final updatedProfile = profile.copyWith(
        jobApplications: updatedApplications,
      );
      await updateCandidateProfile(
        candidateId: candidateId,
        profile: updatedProfile,
      );
    } catch (e) {
      throw Exception('Failed to add job application: $e');
    }
  }

  @override
  Future<void> removeJobApplication({
    required String candidateId,
    required String jobId,
  }) async {
    try {
      final profile = await getCandidateProfile(candidateId: candidateId);
      final updatedApplications = List<String>.from(profile.jobApplications)
        ..removeWhere((id) => id == jobId);
      final updatedProfile = profile.copyWith(
        jobApplications: updatedApplications,
      );
      await updateCandidateProfile(
        candidateId: candidateId,
        profile: updatedProfile,
      );
    } catch (e) {
      throw Exception('Failed to remove job application: $e');
    }
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/jobs_match_response.dart';
import 'package:tabashir/core/network/services/job/tabashir_api_service.dart';
import 'package:tabashir/core/services/isar_service.dart';
import 'package:tabashir/features/ai_job_apply/data/models/location_preference_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/personal_details_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/resume_selection_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/target_role_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/review_model.dart';
import 'package:tabashir/features/ai_job_apply/domain/repositories/ai_job_apply_repository.dart';

/// Implementation of [AiJobApplyRepository]
/// Handles AI job application operations using [TabashirApiService] and [IsarService]
@Injectable(as: AiJobApplyRepository)
class AiJobApplyRepositoryImpl implements AiJobApplyRepository {
  AiJobApplyRepositoryImpl(
    this._tabashirApiService,
    this._isarService,
  );

  final TabashirApiService _tabashirApiService;
  final IsarService _isarService;

  @override
  Future<JobsMatchResponse> applyToJobs({
    required String email,
    required Uint8List fileBytes,
    required String fileName,
    required List<String> positions,
    required List<String> locations,
    required String nationality,
    required String gender,
  }) async {
    try {
      // Convert Uint8List to MultipartFile
      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      );

      // Call the API with MultipartFile
      final response = await _tabashirApiService.applyJobs(
        email,
        multipartFile,
        nationality,
        gender,
        locations,
        positions,
      );

      // API returns ApplyJobsResponse with summary statistics
      // Extract statistics from the response
      final applyResponse = response.data;

      // The API doesn't return matched jobs in this endpoint
      // It only returns statistics about the matching process
      // So we return empty matchedJobs but include the statistics in the total
      return JobsMatchResponse(
        matchedJobs: [], // API doesn't return matched jobs list
        total: applyResponse.summary.rankingResult.matchesFound,
      );
    } on DioException catch (e) {
      throw Exception('Failed to apply to jobs: ${e.message}');
    } catch (e) {
      throw Exception('Failed to apply to jobs: $e');
    }
  }

  @override
  Future<JobsMatchResponse> addClient({
    required String email,
    required Uint8List fileBytes,
    required String fileName,
    required List<String> positions,
    required List<String> locations,
    required String nationality,
    required String gender,
  }) async {
    try {
      // Convert Uint8List to MultipartFile
      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      );

      // Call the API with MultipartFile
      final response = await _tabashirApiService.addClient(
        email,
        multipartFile,
        nationality,
        gender,
        locations,
        positions,
      );

      final applyResponse = response.data;

      return JobsMatchResponse(
        matchedJobs: [], // API doesn't return matched jobs list
        total: applyResponse.summary.rankingResult.matchesFound,
      );
    } on DioException catch (e) {
      throw Exception('Failed to add client: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add client: $e');
    }
  }

  @override
  Future<List<ResumeSelectionModel>> getAvailableResumes({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final resumesJson = prefs.getString('ai_resumes_$userId');
      if (resumesJson == null || resumesJson.isEmpty) {
        return <ResumeSelectionModel>[];
      }

      final resumesList = jsonDecode(resumesJson) as List<dynamic>;
      return resumesList
          .map(
            (json) =>
                ResumeSelectionModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get available resumes: $e');
    }
  }

  @override
  Future<ResumeSelectionModel> saveResumeSelection({
    required String userId,
    required ResumeSelectionModel resume,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final resumesJson = prefs.getString('ai_resumes_$userId');
      final resumes = <ResumeSelectionModel>[];

      if (resumesJson != null && resumesJson.isNotEmpty) {
        final resumesList = jsonDecode(resumesJson) as List<dynamic>;
        resumes.addAll(
          resumesList.map(
            (json) =>
                ResumeSelectionModel.fromJson(json as Map<String, dynamic>),
          ),
        );
      }

      // Check if resume already exists
      final existingIndex = resumes.indexWhere((r) => r.id == resume.id);
      if (existingIndex != -1) {
        resumes[existingIndex] = resume;
      } else {
        resumes.add(resume);
      }

      final updatedJson = jsonEncode(resumes.map((r) => r.toJson()).toList());
      await prefs.setString('ai_resumes_$userId', updatedJson);

      return resume;
    } catch (e) {
      throw Exception('Failed to save resume selection: $e');
    }
  }

  @override
  Future<List<LocationPreferenceModel>> getLocationPreferences({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final preferencesJson = prefs.getString('location_preferences_$userId');
      if (preferencesJson == null || preferencesJson.isEmpty) {
        return <LocationPreferenceModel>[];
      }

      final preferencesList = jsonDecode(preferencesJson) as List<dynamic>;
      return preferencesList
          .map(
            (json) =>
                LocationPreferenceModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Failed to get location preferences: $e');
    }
  }

  @override
  Future<void> saveLocationPreferences({
    required String userId,
    required List<LocationPreferenceModel> preferences,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final preferencesJson = jsonEncode(
        preferences.map((p) => p.toJson()).toList(),
      );
      await prefs.setString('location_preferences_$userId', preferencesJson);
    } catch (e) {
      throw Exception('Failed to save location preferences: $e');
    }
  }

  @override
  Future<PersonalDetailsModel> getPersonalDetails({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final detailsJson = prefs.getString('personal_details_$userId');
      if (detailsJson == null || detailsJson.isEmpty) {
        throw Exception('Personal details not found');
      }

      final details = jsonDecode(detailsJson) as Map<String, dynamic>;
      return PersonalDetailsModel.fromJson(details);
    } catch (e) {
      throw Exception('Failed to get personal details: $e');
    }
  }

  @override
  Future<void> savePersonalDetails({
    required String userId,
    required PersonalDetailsModel details,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final detailsJson = jsonEncode(details.toJson());
      await prefs.setString('personal_details_$userId', detailsJson);
    } catch (e) {
      throw Exception('Failed to save personal details: $e');
    }
  }

  @override
  Future<List<TargetRoleModel>> getTargetRoles({
    required String userId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final rolesJson = prefs.getString('target_roles_$userId');
      if (rolesJson == null || rolesJson.isEmpty) {
        return <TargetRoleModel>[];
      }

      final rolesList = jsonDecode(rolesJson) as List<dynamic>;
      return rolesList
          .map((json) => TargetRoleModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get target roles: $e');
    }
  }

  @override
  Future<void> saveTargetRoles({
    required String userId,
    required List<TargetRoleModel> roles,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final rolesJson = jsonEncode(roles.map((r) => r.toJson()).toList());
      await prefs.setString('target_roles_$userId', rolesJson);
    } catch (e) {
      throw Exception('Failed to save target roles: $e');
    }
  }

  @override
  Future<void> saveReview({
    required ReviewModel review,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final reviewsJson = prefs.getString('ai_job_reviews');
      final reviews = <ReviewModel>[];

      if (reviewsJson != null && reviewsJson.isNotEmpty) {
        final reviewsList = jsonDecode(reviewsJson) as List<dynamic>;
        reviews.addAll(
          reviewsList.map(
            (json) => ReviewModel.fromJson(json as Map<String, dynamic>),
          ),
        );
      }

      reviews.add(review);
      final updatedJson = jsonEncode(reviews.map((r) => r.toJson()).toList());
      await prefs.setString('ai_job_reviews', updatedJson);
    } catch (e) {
      throw Exception('Failed to save review: $e');
    }
  }

  @override
  Future<void> deleteResumeSelection({
    required String userId,
    required String resumeId,
  }) async {
    try {
      final prefs = _isarService.prefs;
      final resumesJson = prefs.getString('ai_resumes_$userId');
      if (resumesJson == null || resumesJson.isEmpty) {
        return;
      }

      final resumesList = jsonDecode(resumesJson) as List<dynamic>;
      final resumes = resumesList
          .map(
            (json) =>
                ResumeSelectionModel.fromJson(json as Map<String, dynamic>),
          )
          .toList();

      resumes.removeWhere((r) => r.id == resumeId);

      final updatedJson = jsonEncode(resumes.map((r) => r.toJson()).toList());
      await prefs.setString('ai_resumes_$userId', updatedJson);
    } catch (e) {
      throw Exception('Failed to delete resume selection: $e');
    }
  }

  @override
  Future<Uint8List> downloadResumeFromCloud({
    required String resumeUrl,
  }) async {
    try {
      final dio = Dio();
      final response = await dio.get<Uint8List>(
        resumeUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.data is Uint8List) {
        return response.data!;
      } else {
        return Uint8List.fromList(response.data! as List<int>);
      }
    } on DioException catch (e) {
      throw Exception('Failed to download resume from cloud: ${e.message}');
    } catch (e) {
      throw Exception('Failed to download resume from cloud: $e');
    }
  }

  @override
  Future<JobsMatchResponse> applyToSpecificJob({
    required String jobId,
    required String email,
    required Uint8List fileBytes,
    required String fileName,
    String? nationality,
    String? gender,
  }) async {
    try {
      // Convert Uint8List to MultipartFile
      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      );

      // Call the API with MultipartFile
      final response = await _tabashirApiService.applyToJob(
        jobId,
        multipartFile,
        email,
        nationality ?? 'Not specified',
        gender ?? 'Not specified',
      );

      // API returns ApplyToJobResponse with application confirmation
      // Convert to JobsMatchResponse format for compatibility
      final applyResponse = response.data;

      // Return single job match with ranking ID
      return JobsMatchResponse(
        matchedJobs: [
          MatchedJob(
            jobId: jobId,
          ),
        ],
        total: 1, // Applied to one job
      );
    } on DioException catch (e) {
      throw Exception('Failed to apply to specific job: ${e.message}');
    } catch (e) {
      throw Exception('Failed to apply to specific job: $e');
    }
  }

  @override
  Future<List<String>> suggestJobTitles({
    required Uint8List fileBytes,
    required String fileName,
  }) async {
    try {
      // Convert Uint8List to MultipartFile
      final multipartFile = MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      );

      // Call the API with MultipartFile
      final response = await _tabashirApiService.suggestJobTitles(
        multipartFile,
      );

      return response.data.suggestedJobTitles;
    } on DioException catch (e) {
      throw Exception('Failed to suggest job titles: ${e.message}');
    } catch (e) {
      throw Exception('Failed to suggest job titles: $e');
    }
  }
}

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/network/models/job_api_response.dart';
import 'package:tabashir/core/network/models/job_details_response.dart';
import 'package:tabashir/core/network/models/jobs_list_response.dart';
import 'package:tabashir/core/network/models/jobs_match_response.dart';
import 'package:tabashir/core/network/services/job/tabashir_api_service.dart';
import 'package:tabashir/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Implementation of [JobsRepository]
/// Handles job operations using [TabashirApiService]
@Injectable(as: JobsRepository)
class JobsRepositoryImpl implements JobsRepository {
  JobsRepositoryImpl(this._tabashirApiService);

  final TabashirApiService _tabashirApiService;

  @override
  Future<List<JobDetailsResponse>> getJobs({
    int page = 0,
    int limit = 20,
    String? search,
    List<String>? locations,
    List<String>? jobTypes,
    List<String>? experienceLevels,
    int? minSalary,
    int? maxSalary,
    List<String>? skills,
    String? sort,
    String? email,
    String? lang,
  }) async {
    AppLogger.debug('\n\n########## [JOBS_REPO] GET JOBS CALLED ##########', tag: 'Jobs');
    AppLogger.debug('[JOBS_REPO] Pagination params - Page: $page, Limit: $limit', tag: 'Jobs');
    if (email != null) {
      AppLogger.debug('[JOBS_REPO] User Email: $email', tag: 'Jobs');
    }
    if (search != null && search.isNotEmpty) {
      AppLogger.debug('[JOBS_REPO] Search query: $search', tag: 'Jobs');
    }
    if (locations != null && locations.isNotEmpty) {
      AppLogger.debug('[JOBS_REPO] Filters - Locations: $locations', tag: 'Jobs');
    }
    if (jobTypes != null && jobTypes.isNotEmpty) {
      AppLogger.debug('[JOBS_REPO] Filters - Job Types: $jobTypes', tag: 'Jobs');
    }
    if (experienceLevels != null && experienceLevels.isNotEmpty) {
      AppLogger.debug('[JOBS_REPO] Filters - Experience Levels: $experienceLevels', tag: 'Jobs');
    }
    if (minSalary != null || maxSalary != null) {
      AppLogger.debug('[JOBS_REPO] Filters - Salary range: $minSalary - $maxSalary', tag: 'Jobs');
    }
    if (skills != null && skills.isNotEmpty) {
      AppLogger.debug('[JOBS_REPO] Filters - Skills: $skills', tag: 'Jobs');
    }
    if (sort != null) {
      AppLogger.debug('[JOBS_REPO] Sort: $sort', tag: 'Jobs');
    }

    try {
      AppLogger.debug('[JOBS_REPO] Calling API service...', tag: 'Jobs');
      final response = await _tabashirApiService.getJobs(
        page: page,
        limit: limit,
        search: search,
        sort: sort,
        lang: lang,
        email: email,
        locations: locations,
        jobTypes: jobTypes,
        experienceLevels: experienceLevels,
        minSalary: minSalary,
        maxSalary: maxSalary,
        skills: skills,
      );

      AppLogger.debug('\n[JOBS_REPO] ✅ API call completed', tag: 'Jobs');
      AppLogger.debug('[JOBS_REPO] Response status: ${response.response.statusCode}', tag: 'Jobs');
      AppLogger.debug('[JOBS_REPO] Response data: ${response.data}', tag: 'Jobs');

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        final jobsList = response.data.jobs ?? [];
        final pagination = response.data.pagination;

        AppLogger.debug('[JOBS_REPO] ✅ Extracted ${jobsList.length} jobs from response', tag: 'Jobs');
        if (pagination != null) {
          AppLogger.debug('[JOBS_REPO] Pagination info: $pagination', tag: 'Jobs');
        }
        AppLogger.debug('[JOBS_REPO] First job: ${jobsList.isNotEmpty ? jobsList.first : "none"}', tag: 'Jobs');
        AppLogger.debug('########## [JOBS_REPO] SUCCESS ##########\n\n', tag: 'Jobs');
        return jobsList;
      } else {
        AppLogger.error('[JOBS_REPO] ❌ API returned error status: ${response.response.statusCode}', tag: 'Jobs');
        throw Exception(
          'Failed to get jobs with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      AppLogger.error('\n[JOBS_REPO] ❌ DioException occurred', tag: 'Jobs');
      AppLogger.debug('[JOBS_REPO] Type: ${e.type}', tag: 'Jobs');
      AppLogger.debug('[JOBS_REPO] Message: ${e.message}', tag: 'Jobs');
      if (e.response != null) {
        AppLogger.debug('[JOBS_REPO] Response status: ${e.response?.statusCode}', tag: 'Jobs');
        AppLogger.debug('[JOBS_REPO] Response data: ${e.response?.data}', tag: 'Jobs');
      }
      AppLogger.error('########## [JOBS_REPO] FAILED ##########\n\n', tag: 'Jobs');
      throw _handleDioError(e);
    } catch (e) {
      AppLogger.error('\n[JOBS_REPO] ❌ Unexpected exception: $e', tag: 'Jobs', error: e);
      AppLogger.error('########## [JOBS_REPO] FAILED ##########\n\n', tag: 'Jobs');
      throw Exception('Failed to get jobs: $e');
    }
  }

  @override
  Future<JobDetailsResponse> getJobById({
    required String jobId,
    String? email,
  }) async {
    try {
      AppLogger.debug('[JOBS_REPO] getJobById called with jobId: $jobId, email: $email', tag: 'Jobs');
      final response = await _tabashirApiService.getJobById(jobId, null, email);

      AppLogger.debug('[JOBS_REPO] API response status: ${response.response.statusCode}', tag: 'Jobs');
      AppLogger.debug('[JOBS_REPO] API response data: ${response.data}', tag: 'Jobs');

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        // Unwrap the job data from the API response
        final jobData = response.data.job;
        if (jobData != null) {
          AppLogger.debug('[JOBS_REPO] Successfully unwrapped job data: $jobData', tag: 'Jobs');
          return jobData;
        } else {
          AppLogger.debug('[JOBS_REPO] Job data is null in response', tag: 'Jobs');
          throw Exception('Job not found in response');
        }
      } else {
        throw Exception(
          'Failed to get job details with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      AppLogger.error('[JOBS_REPO] DioException: ${e.message}', tag: 'Jobs');
      throw _handleDioError(e);
    } catch (e) {
      AppLogger.error('[JOBS_REPO] Exception: $e', tag: 'Jobs', error: e);
      throw Exception('Failed to get job details: $e');
    }
  }

  @override
  Future<AppliedJobsResponse> getAppliedJobs({
    required String email,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _tabashirApiService.getAppliedJobs(
        email,
        page: page,
        limit: limit,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to get applied jobs with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to get applied jobs: $e');
    }
  }

  @override
  Future<JobsMatchResponse> applyToJob({
    required String jobId,
    required File resumeFile,
    required String email,
    required String nationality,
    required String gender,
  }) async {
    try {
      final response = await _tabashirApiService.applyToJob(
        jobId,
        MultipartFile.fromFileSync(resumeFile.path),
        email,
        nationality,
        gender,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        // Convert ApplyToJobResponse to JobsMatchResponse for UI compatibility
        return const JobsMatchResponse();
      } else {
        throw Exception(
          'Failed to apply to job with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to apply to job: $e');
    }
  }

  /// Handle Dio errors and convert to meaningful exceptions
  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case final DioExceptionType receiveTimeout:
        return Exception('Connection timeout. Please try again.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? 'Request failed';
        return Exception('$message (Status: $statusCode)');
      case DioExceptionType.cancel:
        return Exception('Request was cancelled');
      case DioExceptionType.connectionError:
        return Exception('No internet connection. Please check your network.');
      default:
        return Exception('An unexpected error occurred: ${e.message}');
    }
  }
}

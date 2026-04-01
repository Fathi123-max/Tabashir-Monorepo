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
  }) async {
    print('\n\n########## [JOBS_REPO] GET JOBS CALLED ##########');
    print('[JOBS_REPO] Pagination params - Page: $page, Limit: $limit');
    if (email != null) {
      print('[JOBS_REPO] User Email: $email');
    }
    if (search != null && search.isNotEmpty) {
      print('[JOBS_REPO] Search query: $search');
    }
    if (locations != null && locations.isNotEmpty) {
      print('[JOBS_REPO] Filters - Locations: $locations');
    }
    if (jobTypes != null && jobTypes.isNotEmpty) {
      print('[JOBS_REPO] Filters - Job Types: $jobTypes');
    }
    if (experienceLevels != null && experienceLevels.isNotEmpty) {
      print('[JOBS_REPO] Filters - Experience Levels: $experienceLevels');
    }
    if (minSalary != null || maxSalary != null) {
      print('[JOBS_REPO] Filters - Salary range: $minSalary - $maxSalary');
    }
    if (skills != null && skills.isNotEmpty) {
      print('[JOBS_REPO] Filters - Skills: $skills');
    }
    if (sort != null) {
      print('[JOBS_REPO] Sort: $sort');
    }

    try {
      print('[JOBS_REPO] Calling API service...');
      final response = await _tabashirApiService.getJobs(
        page: page,
        limit: limit,
        search: search,
        locations: locations,
        jobTypes: jobTypes,
        experienceLevels: experienceLevels,
        minSalary: minSalary,
        maxSalary: maxSalary,
        skills: skills,
        sort: sort,
        email: email,
      );

      print('\n[JOBS_REPO] ✅ API call completed');
      print('[JOBS_REPO] Response status: ${response.response.statusCode}');
      print('[JOBS_REPO] Response data: ${response.data}');

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        final jobsList = response.data.jobs ?? [];
        final pagination = response.data.pagination;

        print('[JOBS_REPO] ✅ Extracted ${jobsList.length} jobs from response');
        if (pagination != null) {
          print('[JOBS_REPO] Pagination info: $pagination');
        }
        print(
          '[JOBS_REPO] First job: ${jobsList.isNotEmpty ? jobsList.first : "none"}',
        );
        print('########## [JOBS_REPO] SUCCESS ##########\n\n');
        return jobsList;
      } else {
        print(
          '[JOBS_REPO] ❌ API returned error status: ${response.response.statusCode}',
        );
        throw Exception(
          'Failed to get jobs with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('\n[JOBS_REPO] ❌ DioException occurred');
      print('[JOBS_REPO] Type: ${e.type}');
      print('[JOBS_REPO] Message: ${e.message}');
      if (e.response != null) {
        print('[JOBS_REPO] Response status: ${e.response?.statusCode}');
        print('[JOBS_REPO] Response data: ${e.response?.data}');
      }
      print('########## [JOBS_REPO] FAILED ##########\n\n');
      throw _handleDioError(e);
    } catch (e) {
      print('\n[JOBS_REPO] ❌ Unexpected exception: $e');
      print('########## [JOBS_REPO] FAILED ##########\n\n');
      throw Exception('Failed to get jobs: $e');
    }
  }

  @override
  Future<JobDetailsResponse> getJobById({
    required String jobId,
    String? email,
  }) async {
    try {
      print('[JOBS_REPO] getJobById called with jobId: $jobId, email: $email');
      final response = await _tabashirApiService.getJobById(jobId, null, email);

      print('[JOBS_REPO] API response status: ${response.response.statusCode}');
      print('[JOBS_REPO] API response data: ${response.data}');

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        // Unwrap the job data from the API response
        final jobData = response.data.job;
        if (jobData != null) {
          print('[JOBS_REPO] Successfully unwrapped job data: $jobData');
          return jobData;
        } else {
          print('[JOBS_REPO] Job data is null in response');
          throw Exception('Job not found in response');
        }
      } else {
        throw Exception(
          'Failed to get job details with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('[JOBS_REPO] DioException: ${e.message}');
      throw _handleDioError(e);
    } catch (e) {
      print('[JOBS_REPO] Exception: $e');
      throw Exception('Failed to get job details: $e');
    }
  }

  @override
  Future<AppliedJobsResponse> getAppliedJobs({
    required String email,
  }) async {
    try {
      final response = await _tabashirApiService.getAppliedJobs(email);

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

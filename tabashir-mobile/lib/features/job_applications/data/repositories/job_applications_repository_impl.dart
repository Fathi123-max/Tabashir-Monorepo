import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';
import 'package:tabashir/core/network/models/jobs_count_response.dart';
import 'package:tabashir/core/network/models/email_model.dart';
import 'package:tabashir/core/network/services/job/tabashir_api_service.dart';
import 'package:tabashir/features/job_applications/domain/repositories/job_applications_repository.dart';

/// Implementation of [JobApplicationsRepository]
/// Handles job application operations using [TabashirApiService]
@Injectable(as: JobApplicationsRepository)
class JobApplicationsRepositoryImpl implements JobApplicationsRepository {
  JobApplicationsRepositoryImpl(this._tabashirApiService);

  final TabashirApiService _tabashirApiService;

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
  Future<JobsCountResponse> getAppliedJobsCount({
    required String email,
  }) async {
    try {
      final emailModel = EmailModel(email: email);
      final response = await _tabashirApiService.getAppliedJobsCount(
        emailModel,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to get applied jobs count with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to get applied jobs count: $e');
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

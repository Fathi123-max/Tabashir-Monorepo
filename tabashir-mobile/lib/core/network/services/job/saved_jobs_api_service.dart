import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/saved_jobs_response.dart';

part 'saved_jobs_api_service.g.dart';

/// API Service for managing saved jobs
///
/// Provides methods to:
/// - Get all saved job IDs
/// - Save a job
/// - Remove a saved job
@RestApi(baseUrl: '/api/v1')
abstract class SavedJobsApiService {
  @factoryMethod
  factory SavedJobsApiService(Dio dio) = _SavedJobsApiService;

  /// GET /jobs/saved-jobs
  /// Get all saved job IDs for the authenticated user
  @GET('/jobs/saved-jobs')
  Future<SavedJobsResponse> getSavedJobs();

  /// POST /jobs/saved-jobs
  /// Save a job for the authenticated user
  /// Body: { jobId: String }
  @POST('/jobs/saved-jobs')
  Future<SavedJobsResponse> saveJob(
    @Body() Map<String, dynamic> requestBody,
  );

  /// DELETE /jobs/saved-jobs/{jobId}
  /// Remove a job from saved jobs
  @DELETE('/jobs/saved-jobs/{jobId}')
  Future<SavedJobsResponse> unsaveJob(
    @Path('jobId') String jobId,
  );

  /// POST /jobs/sync-jobs
  /// Sync jobs from external API to local database
  /// Body: { jobs: Array<{id: string, title: string, ...}> }
  @POST('/jobs/sync-jobs')
  Future<dynamic> syncJobs(
    @Body() Map<String, dynamic> requestBody,
  );
}

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
@RestApi(baseUrl: 'http://localhost:5001/api/mobile')
abstract class SavedJobsApiService {
  @factoryMethod
  factory SavedJobsApiService(Dio dio) = _SavedJobsApiService;

  /// GET /saved-jobs
  /// Get all saved job IDs for the authenticated user
  @GET('/saved-jobs')
  Future<SavedJobsResponse> getSavedJobs();

  /// POST /saved-jobs
  /// Save a job for the authenticated user
  /// Body: { jobId: String }
  @POST('/saved-jobs')
  Future<SavedJobsResponse> saveJob(
    @Body() Map<String, dynamic> requestBody,
  );

  /// DELETE /saved-jobs/{jobId}
  /// Remove a job from saved jobs
  @DELETE('/saved-jobs/{jobId}')
  Future<SavedJobsResponse> unsaveJob(
    @Path('jobId') String jobId,
  );

  /// POST /sync-jobs
  /// Sync jobs from external API to local database
  /// Body: { jobs: Array<{id: string, title: string, ...}> }
  @POST('/sync-jobs')
  Future<dynamic> syncJobs(
    @Body() Map<String, dynamic> requestBody,
  );
}

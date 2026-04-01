import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/raw_cv_input.dart';
import '../../models/cv_format_response.dart';
import '../../models/email_model.dart';
import '../../models/formatted_cv_response.dart';
import '../../models/job_api_response.dart';
import '../../models/job_create_model.dart';
import '../../models/job_create_payload.dart';
import '../../models/job_details_response.dart';
import '../../models/applied_jobs_response.dart';
import '../../models/jobs_count_response.dart';
import '../../models/jobs_count_by_city_response.dart';
import '../../models/jobs_list_response.dart';
import '../../models/jobs_match_response.dart';
import '../../models/jobs_match_list_response.dart';
import '../../models/job_update_model.dart';
import '../../models/job_update_response.dart';
import '../../models/jobs_monthly_count_response.dart';
import '../../models/job_applicants_count_response.dart';
import '../../models/send_linkedin_email_request.dart';
import '../../models/suggest_job_titles_response.dart';
import 'package:tabashir/core/network/models/job/ai_client_response.dart';

part 'tabashir_api_service.g.dart';

/// REST API client for Tabashir backend
@RestApi(baseUrl: '/api/v1/resumes')
abstract class TabashirApiService {
  factory TabashirApiService(Dio dio, {String baseUrl}) = _TabashirApiService;

  /// GET endpoint to fetch AI client profile data
  @GET('/client')
  Future<HttpResponse<AiClientResponse>> getClient();

  /// GET endpoint to fetch job application rankings for a given email
  @GET('/applied-jobs')
  Future<HttpResponse<AppliedJobsResponse>> getAppliedJobs(
    @Query('email') String email,
  );

  /// Get number of jobs applied by email
  @POST('/applied-jobs-count')
  Future<HttpResponse<JobsCountResponse>> getAppliedJobsCount(
    @Body() EmailModel emailModel,
  );

  /// POST endpoint to process resume and find matching jobs with rankings
  @POST('/apply')
  @MultiPart()
  Future<HttpResponse<ApplyJobsResponse>> applyJobs(
    @Part(name: 'email') String email,
    @Part() MultipartFile file,
    @Part(name: 'nationality') String nationality,
    @Part(name: 'gender') String gender,
    @Part(name: 'locations') List<String> locations,
    @Part(name: 'positions') List<String> positions,
  );

  /// POST endpoint to add a new client and find matching jobs
  @POST('/add_client')
  @MultiPart()
  Future<HttpResponse<ApplyJobsResponse>> addClient(
    @Part(name: 'email') String email,
    @Part() MultipartFile file,
    @Part(name: 'nationality') String nationality,
    @Part(name: 'gender') String gender,
    @Part(name: 'locations') List<String> locations,
    @Part(name: 'positions') List<String> positions,
  );

  /// PUT endpoint to update an existing client and refresh job matching
  @PUT('/update_client')
  @MultiPart()
  Future<HttpResponse<ApplyJobsResponse>> updateClient(
    @Part(name: 'email') String email,
    @Part(name: 'file') MultipartFile? file,
    @Part(name: 'nationality') String nationality,
    @Part(name: 'gender') String gender,
    @Part(name: 'locations') List<String> locations,
    @Part(name: 'positions') List<String> positions,
  );

  /// POST endpoint to convert a CV to ATS format
  /// Returns binary DOCX file
  @POST('/format')
  @MultiPart()
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> formatCV(
    @Part() MultipartFile file,
    @Part(name: 'output_language') String? outputLanguage,
  );

  /// POST endpoint to receive raw CV text and return structured JSON format
  @POST('/format-cv-object')
  Future<HttpResponse<FormattedCVResponse>> formatCVFromRaw(
    @Body() RawCVInput rawCVInput,
  );

  /// Translate CV to Arabic
  /// Returns binary DOCX file
  @POST('/translate')
  @MultiPart()
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> translateCV(
    @Part() MultipartFile file,
  );

  /// Get all jobs with pagination, search, and optional filters
  @GET('/jobs')
  Future<HttpResponse<JobsListResponse>> getJobs({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('search') String? search,
    @Query('location') String? location,
    @Query('experience') String? experience,
    @Query('sort') String? sort,
    @Query('lang') String? lang,
    @Query('email') String? email,
    @Query('locations') List<String>? locations,
    @Query('jobTypes') List<String>? jobTypes,
    @Query('experienceLevels') List<String>? experienceLevels,
    @Query('minSalary') int? minSalary,
    @Query('maxSalary') int? maxSalary,
    @Query('skills') List<String>? skills,
  });

  /// Get jobs count by city
  @GET('/jobs/count-by-city')
  Future<HttpResponse<JobsCountByCityResponse>> getJobsCountByCity(
    @Query('keyword') String keyword,
  );

  /// Get jobs ranked by semantic match to user's profile (AI-powered matching)
  @GET('/jobs/matched')
  Future<HttpResponse<JobsMatchListResponse>> getJobMatches(
    @Query('email') String email,
    @Query('limit') int? limit,
    @Query('page') int? page,
  );

  /// Get jobs monthly count
  @GET('/jobs/monthly-count')
  Future<HttpResponse<JobsMonthlyCountResponse>> getJobsMonthlyCount(
    @Query('keyword') String keyword,
  );

  /// Get job by ID
  @GET('/jobs/{job_id}')
  Future<HttpResponse<JobApiResponse>> getJobById(
    @Path('job_id') String jobId,
    @Query('lang') String? lang,
    @Query('email') String? email,
  );

  /// Get applicants count for a job
  @GET('/jobs/{job_id}/applicants-count')
  Future<HttpResponse<JobApplicantsCountResponse>> getApplicantsCount(
    @Path('job_id') String jobId,
    @Query('status') String? status,
  );

  /// Create a new job
  @POST('/jobs')
  Future<HttpResponse<JobDetailsResponse>> createJob(
    @Body() JobCreatePayload jobCreatePayload,
  );

  /// Update a job
  @PUT('/jobs/{job_id}')
  Future<HttpResponse<JobUpdateResponse>> updateJob(
    @Path('job_id') String jobId,
    @Body() JobUpdate jobUpdate,
  );

  /// Apply to a specific job
  @POST('/{job_id}/apply')
  @MultiPart()
  Future<HttpResponse<ApplyToJobResponse>> applyToJob(
    @Path('job_id') String jobId,
    @Part() MultipartFile file,
    @Part(name: 'email') String email,
    @Part(name: 'nationality') String nationality,
    @Part(name: 'gender') String gender,
  );

  /// Send LinkedIn email
  @POST('/send-linkedin-email')
  Future<HttpResponse<void>> sendLinkedInEmail(
    @Body() SendLinkedInEmailRequest request,
  );

  /// Suggest job titles based on CV
  @POST('/suggest-job-titles')
  @MultiPart()
  Future<HttpResponse<SuggestJobTitlesResponse>> suggestJobTitles(
    @Part() MultipartFile file,
  );

  /// Health check
  @GET('/health')
  Future<HttpResponse<Map<String, String>>> healthCheck();
}

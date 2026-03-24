import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/core/network/models/resume_response/resume_response.dart';

part 'resume_api_service.g.dart';

/// Resume API Service for basic CRUD operations
///
/// Connects to the production backend (localhost:5001) which provides
/// simple resume CRUD operations (upload, list, get, update, delete).
///
/// For PRODUCTION, use TabashirApiService which connects to
/// backend.tabashir.ae and provides advanced features:
/// - CV formatting for ATS (/format)
/// - CV translation to Arabic (/translate)
/// - AI job matching (/apply)
/// - Job listings and applications (/jobs)
///
/// ARCHITECTURE:
/// - ResumeApiService → localhost:5001/api (CRUD)
/// - TabashirApiService → backend.tabashir.ae/api (processing)
///
/// See: lib/core/network/services/job/tabashir_api_service.dart for production API
@RestApi(baseUrl: '/api/v1/resumes')
abstract class ResumeApiService {
  @factoryMethod
  factory ResumeApiService(Dio dio) = _ResumeApiService;

  /// GET /resumes
  /// List all resumes for the authenticated user
  @GET('')
  Future<ResumeListResponse> getResumes();

  /// POST /resumes
  /// Upload a new resume file
  @MultiPart()
  @POST('')
  Future<ResumeUploadResponse> uploadResume(
    @Part(name: 'file') MultipartFile file,
  );

  /// GET /resumes/{id}
  /// Get specific resume details
  @GET('/{id}')
  Future<ResumeDetailsResponse> getResume(
    @Path('id') String resumeId,
  );

  /// PUT /resumes/{id}
  /// Update a resume (re-upload file)
  @MultiPart()
  @PUT('/{id}')
  Future<ResumeUploadResponse> updateResume(
    @Path('id') String resumeId,
    @Part(name: 'file') MultipartFile file,
  );

  /// DELETE /resumes/{id}
  /// Delete a resume
  @DELETE('/{id}')
  Future<ResumeDeleteResponse> deleteResume(
    @Path('id') String resumeId,
  );

  /// POST /resumes/{id}/duplicate
  /// Duplicate a resume
  @POST('/{id}/duplicate')
  Future<ResumeDuplicateResponse> duplicateResume(
    @Path('id') String resumeId,
  );

  /// POST /resumes/{id}/export/pdf
  /// Export resume as PDF
  @POST('/{id}/export/pdf')
  Future<ResumeExportResponse> exportResumeAsPdf(
    @Path('id') String resumeId,
  );

  /// POST /resumes/{id}/export/word
  /// Export resume as Word document
  @POST('/{id}/export/word')
  Future<HttpResponse> exportResumeAsWord(
    @Path('id') String resumeId,
  );

  /// POST /resumes/{id}/translate
  /// Translate resume to another language
  @POST('/{id}/translate')
  Future<ResumeTranslateResponse> translateResume(
    @Path('id') String resumeId,
    @Body() Map<String, dynamic> request,
  );

  /// POST /resumes/save-and-generate
  /// Save resume data and generate AI resume
  @POST('/save-and-generate')
  Future<ResumeItem> saveAndGenerate(@Body() Map<String, dynamic> body);
}

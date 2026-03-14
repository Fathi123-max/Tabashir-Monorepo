import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/ai_resume/create_ai_resume_request.dart';
import '../../models/ai_resume/create_ai_resume_response.dart';

part 'ai_resume_api_service.g.dart';

/// AI Resume API client
@RestApi(baseUrl: '/api/v1/resumes')
abstract class AiResumeApiService {
  factory AiResumeApiService(Dio dio) = _AiResumeApiService;

  /// Create AI resume
  @POST('/ai-resume/create')
  Future<HttpResponse<CreateAiResumeResponse>> createAiResume(
    @Body() CreateAiResumeRequest request,
  );
}

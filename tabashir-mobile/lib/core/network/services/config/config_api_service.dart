import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter/foundation.dart';

import '../../models/config/ai_job_apply_config_response.dart';

part 'config_api_service.g.dart';

/// Configuration API client for fetching app configuration
@RestApi(baseUrl: '/api/v1')
abstract class ConfigApiService {
  factory ConfigApiService(Dio dio) = _ConfigApiService;

  /// Get AI Job Apply configuration from backend
  /// Returns roles, locations, nationalities, and settings
  @GET('/mobile/ai-job-apply/config')
  Future<HttpResponse<AiJobApplyConfigResponse>> getAiJobApplyConfig();
}

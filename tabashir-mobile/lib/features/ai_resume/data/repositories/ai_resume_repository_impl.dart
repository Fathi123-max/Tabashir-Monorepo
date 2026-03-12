import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/ai_resume/create_ai_resume_request.dart';
import 'package:tabashir/core/network/models/ai_resume/create_ai_resume_response.dart';
import 'package:tabashir/core/network/services/ai_resume/ai_resume_api_service.dart';
import 'package:tabashir/features/ai_resume/domain/repositories/ai_resume_repository.dart';

/// Implementation of [AiResumeRepository]
/// Handles AI resume operations using [AiResumeApiService]
@Injectable(as: AiResumeRepository)
class AiResumeRepositoryImpl implements AiResumeRepository {
  AiResumeRepositoryImpl(this._aiResumeApiService);

  final AiResumeApiService _aiResumeApiService;

  @override
  Future<CreateAiResumeResponse> createAiResume({
    required CreateAiResumeRequest request,
  }) async {
    try {
      final response = await _aiResumeApiService.createAiResume(
        request,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to create AI resume with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to create AI resume: $e');
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

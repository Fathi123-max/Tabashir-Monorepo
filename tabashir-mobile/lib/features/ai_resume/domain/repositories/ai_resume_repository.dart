import 'package:tabashir/core/network/models/ai_resume/create_ai_resume_request.dart';
import 'package:tabashir/core/network/models/ai_resume/create_ai_resume_response.dart';

/// Repository interface for AI resume operations
/// Defines the contract for AI resume data operations
abstract class AiResumeRepository {
  /// Create AI resume
  /// Returns [CreateAiResumeResponse] with generated resume data
  Future<CreateAiResumeResponse> createAiResume({
    required CreateAiResumeRequest request,
  });
}

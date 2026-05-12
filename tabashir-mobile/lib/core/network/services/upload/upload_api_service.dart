import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/upload/upload_response.dart';

part 'upload_api_service.g.dart';

/// File upload API client
@RestApi(baseUrl: '/api/v1/uploads')
abstract class UploadApiService {
  factory UploadApiService(Dio dio) = _UploadApiService;

  /// Upload file
  @POST('/uploadthing')
  @MultiPart()
  Future<HttpResponse<UploadResponse>> uploadFile(
    @Part(name: 'file') MultipartFile file,
    @Part(name: 'fileName') String? fileName,
  );
}

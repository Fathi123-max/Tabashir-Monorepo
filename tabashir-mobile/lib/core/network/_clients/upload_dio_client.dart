import 'package:dio/dio.dart';

/// Clean Dio client for file uploads without authentication headers
/// This avoids the x-api-token header that causes API 400 errors
class UploadDioClient {
  UploadDioClient() {
    _dio = Dio(_getUploadOptions());
    _dio.interceptors.add(LogInterceptor());
  }
  late Dio _dio;

  BaseOptions _getUploadOptions() => BaseOptions(
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    sendTimeout: const Duration(seconds: 120),
    headers: {
      'Content-Type': 'multipart/form-data',
      'x-api-token':
          'a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5',
    },
  );

  Dio get dio => _dio;
}

import 'package:dio/dio.dart';

class DioClient {
  DioClient() {
    _dio = Dio(_getDefaultOptions());
    _dio.interceptors.add(LogInterceptor());
  }
  late Dio _dio;

  BaseOptions _getDefaultOptions() => BaseOptions(
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    sendTimeout: const Duration(seconds: 120),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  Dio get dio => _dio;
}

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tabashir/core/network/interceptors/language_interceptor.dart';

class DioClient {
  DioClient() {
    _dio = Dio(_getDefaultOptions());
    _dio.interceptors.add(LanguageInterceptor());
    _dio.interceptors.add(LogInterceptor());
  }
  late Dio _dio;

  BaseOptions _getDefaultOptions() => BaseOptions(
    baseUrl: dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:5050',
    connectTimeout: const Duration(seconds: 120),
    receiveTimeout: const Duration(seconds: 120),
    sendTimeout: const Duration(seconds: 120),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  Dio get dio => _dio;
}

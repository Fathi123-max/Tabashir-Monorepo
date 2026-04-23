import 'package:dio/dio.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/language_service.dart';

/// Interceptor to automatically add 'lang' parameter to all requests
class LanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      final languageService = getIt<LanguageService>();
      final lang = languageService.currentLanguage;
      
      // Add lang to query parameters
      final queryParams = Map<String, dynamic>.from(options.queryParameters);
      if (!queryParams.containsKey('lang')) {
        queryParams['lang'] = lang;
        options.queryParameters = queryParams;
      }
    } catch (_) {
      // Fallback if DI is not yet initialized or other error
    }
    
    super.onRequest(options, handler);
  }
}

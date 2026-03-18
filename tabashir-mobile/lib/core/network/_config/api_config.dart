/// API configuration settings
/// Contains timeout values, headers, and other configuration
library;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  ApiConfig._();

  // ==========================================
  // Timeout Configuration
  // ==========================================
  static const Duration connectTimeout = Duration(seconds: 120);
  static const Duration receiveTimeout = Duration(seconds: 120);
  static const Duration sendTimeout = Duration(seconds: 120);

  // ==========================================
  // API Token for localhost:5001
  // Loaded from environment variables (.env file)
  // ==========================================
  static String get appApiToken =>
      dotenv.env['TABASHIR_API_TOKEN'] ??
      'a5c3b58a2d0f49b1949ef70c5e91710b8e04e88ab62cc4f814d388d6e3910ae5';

  // ==========================================
  // Default Headers
  // ==========================================
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  static final Map<String, String> appApiHeaders = {
    'Content-Type': 'application/json',
    'x-api-token': appApiToken,
  };

  // ==========================================
  // Content Types
  // ==========================================
  static const String contentTypeJson = 'application/json';
  static const String contentTypeForm = 'application/x-www-form-urlencoded';
  static const String contentTypeMultipart = 'multipart/form-data';
}

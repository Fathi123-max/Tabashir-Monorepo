import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/upload/upload_response.dart';
import 'package:tabashir/core/network/services/upload/upload_api_service.dart';
import 'package:tabashir/features/upload/domain/repositories/upload_repository.dart';

/// Implementation of [UploadRepository]
/// Handles file upload operations using [UploadApiService]
@Injectable(as: UploadRepository)
class UploadRepositoryImpl implements UploadRepository {
  UploadRepositoryImpl(this._uploadApiService);

  final UploadApiService _uploadApiService;

  @override
  Future<UploadResponse> uploadFile({
    required File file,
    String? fileName,
  }) async {
    try {
      final multipartFile = MultipartFile.fromFileSync(
        file.path,
        filename: fileName,
      );

      final response = await _uploadApiService.uploadFile(
        multipartFile,
        fileName,
      );

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception(
          'Failed to upload file with status: ${response.response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to upload file: $e');
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

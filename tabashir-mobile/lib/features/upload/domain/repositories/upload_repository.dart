import 'dart:io';

import 'package:tabashir/core/network/models/upload/upload_response.dart';

/// Repository interface for file upload operations
/// Defines the contract for file upload data operations
abstract class UploadRepository {
  /// Upload file to the server
  /// Returns [UploadResponse] with uploaded file information
  Future<UploadResponse> uploadFile({
    required File file,
    String? fileName,
  });
}

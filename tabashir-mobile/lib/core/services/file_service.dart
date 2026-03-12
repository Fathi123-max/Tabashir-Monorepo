import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// Service to handle file operations
class FileService {
  FileService._();
  static FileService? _instance;
  static FileService get instance => _instance ??= FileService._();

  final ImagePicker _imagePicker = ImagePicker();

  /// Pick an image from gallery or camera
  Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
    double? maxWidth,
    double? maxHeight,
    int quality = 80,
  }) async {
    try {
      final image = await _imagePicker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
      return image;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  /// Pick multiple images
  Future<List<XFile>> pickMultipleImages({
    int maxImages = 10,
    double? maxWidth,
    double? maxHeight,
    int quality = 80,
  }) async {
    try {
      final images = await _imagePicker.pickMultiImage(
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: quality,
      );
      return images.take(maxImages).toList();
    } catch (e) {
      print('Error picking multiple images: $e');
      return [];
    }
  }

  /// Pick a video
  Future<XFile?> pickVideo({
    ImageSource source = ImageSource.gallery,
    double? maxWidth,
    double? maxHeight,
    int maxDuration = 60,
  }) async {
    try {
      final video = await _imagePicker.pickVideo(
        source: source,
        maxDuration: Duration(seconds: maxDuration),
      );
      return video;
    } catch (e) {
      print('Error picking video: $e');
      return null;
    }
  }

  /// Pick a file (document)
  Future<XFile?> pickDocument() async {
    try {
      // Note: For document picking, we might want to use a different package
      // like file_picker or document_picker depending on requirements
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      return pickedFile;
    } catch (e) {
      print('Error picking document: $e');
      return null;
    }
  }

  /// Save a file to app's documents directory
  Future<File?> saveFile({
    required String fileName,
    required Uint8List bytes,
    String? subDirectory,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = subDirectory != null
          ? path.join(directory.path, subDirectory, fileName)
          : path.join(directory.path, fileName);

      final file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      print('Error saving file: $e');
      return null;
    }
  }

  /// Read a file from app's documents directory
  Future<Uint8List?> readFile({
    required String fileName,
    String? subDirectory,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = subDirectory != null
          ? path.join(directory.path, subDirectory, fileName)
          : path.join(directory.path, fileName);

      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsBytes();
      }
      return null;
    } catch (e) {
      print('Error reading file: $e');
      return null;
    }
  }

  /// Delete a file
  Future<bool> deleteFile({
    required String fileName,
    String? subDirectory,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = subDirectory != null
          ? path.join(directory.path, subDirectory, fileName)
          : path.join(directory.path, fileName);

      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      print('Error deleting file: $e');
      return false;
    }
  }

  /// Get file size in bytes
  Future<int> getFileSize({
    required String fileName,
    String? subDirectory,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = subDirectory != null
          ? path.join(directory.path, subDirectory, fileName)
          : path.join(directory.path, fileName);

      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      print('Error getting file size: $e');
      return 0;
    }
  }

  /// Check if file exists
  Future<bool> fileExists({
    required String fileName,
    String? subDirectory,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = subDirectory != null
          ? path.join(directory.path, subDirectory, fileName)
          : path.join(directory.path, fileName);

      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      print('Error checking file existence: $e');
      return false;
    }
  }

  /// Get app documents directory
  Future<Directory> getDocumentsDirectory() async =>
      getApplicationDocumentsDirectory();

  /// Create a subdirectory
  Future<Directory> createSubDirectory(String subDirectory) async {
    final directory = await getApplicationDocumentsDirectory();
    final targetPath = path.join(directory.path, subDirectory);
    final targetDirectory = Directory(targetPath);

    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    return targetDirectory;
  }
}

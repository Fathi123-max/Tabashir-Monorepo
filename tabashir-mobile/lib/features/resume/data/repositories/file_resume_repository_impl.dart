import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/core/network/models/resume_response/resume_response.dart';
import 'package:tabashir/core/network/services/resume/resume_api_service.dart';
import 'package:tabashir/features/resume/domain/repositories/file_resume_repository.dart';

/// Implementation of FileResumeRepository
/// Handles file-based resume operations via backend API
@Injectable(as: FileResumeRepository)
class FileResumeRepositoryImpl implements FileResumeRepository {
  FileResumeRepositoryImpl(this._resumeApiService);

  final ResumeApiService _resumeApiService;

  @override
  Future<List<ResumeItem>> getAllResumes() async {
    try {
      final response = await _resumeApiService.getResumes();
      return response.resumes;
    } catch (e) {
      throw Exception('Failed to get resumes: $e');
    }
  }

  @override
  Future<ResumeItem> getResume({
    required String resumeId,
  }) async {
    try {
      final response = await _resumeApiService.getResume(resumeId);
      return response.resume;
    } catch (e) {
      throw Exception('Failed to get resume: $e');
    }
  }

  @override
  Future<ResumeItem> uploadResume({
    required File file,
  }) async {
    try {
      final fileName = file.path.split('/').last;
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );

      final response = await _resumeApiService.uploadResume(multipartFile);
      return response.resume;
    } catch (e) {
      throw Exception('Failed to upload resume: $e');
    }
  }

  @override
  Future<ResumeItem> updateResume({
    required String resumeId,
    required File file,
  }) async {
    try {
      final fileName = file.path.split('/').last;
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );

      final response = await _resumeApiService.updateResume(
        resumeId,
        multipartFile,
      );
      return response.resume;
    } catch (e) {
      throw Exception('Failed to update resume: $e');
    }
  }

  @override
  Future<void> deleteResume({
    required String resumeId,
  }) async {
    try {
      await _resumeApiService.deleteResume(resumeId);
    } catch (e) {
      throw Exception('Failed to delete resume: $e');
    }
  }

  @override
  Future<ResumeItem> duplicateResume({
    required String resumeId,
  }) async {
    try {
      final response = await _resumeApiService.duplicateResume(resumeId);
      return response.resume;
    } catch (e) {
      throw Exception('Failed to duplicate resume: $e');
    }
  }

  @override
  Future<String> exportResumeAsPdf({
    required String resumeId,
  }) async {
    try {
      final response = await _resumeApiService.exportResumeAsPdf(resumeId);
      return response.exportUrl;
    } catch (e) {
      throw Exception('Failed to export resume to PDF: $e');
    }
  }

  @override
  Future<String> exportResumeAsWord({
    required String resumeId,
  }) async {
    try {
      // Get the binary data
      final response = await _resumeApiService.exportResumeAsWord(resumeId);

      // Save to temporary file
      final tempDir = Directory.systemTemp;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${tempDir.path}/resume_$timestamp.docx');

      // Extract binary data from HttpResponse
      final bytes = response.data as List<int>;
      await file.writeAsBytes(bytes);

      return file.path;
    } catch (e) {
      throw Exception('Failed to export resume to Word: $e');
    }
  }

  @override
  Future<ResumeItem> translateResume({
    required String resumeId,
    required String targetLanguage,
  }) async {
    try {
      final response = await _resumeApiService.translateResume(
        resumeId,
        {'targetLanguage': targetLanguage},
      );
      return response.resume;
    } catch (e) {
      throw Exception('Failed to translate resume: $e');
    }
  }
}

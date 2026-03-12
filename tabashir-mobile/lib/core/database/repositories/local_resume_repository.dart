import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:tabashir/core/database/models/local_resume.dart';
import 'package:tabashir/core/services/isar_service.dart';

/// Repository for managing local resumes stored in SharedPreferences
class LocalResumeRepository {
  LocalResumeRepository(this._isarService);

  final IsarService _isarService;

  /// Get all local resumes
  Future<List<LocalResume>> getAllResumes() async {
    final prefs = _isarService.prefs;
    final resumesJson = prefs.getStringList('local_resumes') ?? <String>[];

    return resumesJson
        .map(
          (jsonStr) =>
              LocalResume.fromJson(jsonDecode(jsonStr) as Map<String, dynamic>),
        )
        .toList();
  }

  /// Get a specific resume by ID
  Future<LocalResume?> getResumeById(String id) async {
    final resumes = await getAllResumes();
    try {
      return resumes.firstWhere((resume) => resume.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Add a new resume from a file
  /// Returns the created LocalResume
  Future<LocalResume> addResume({
    required String name,
    required String title,
    required String filePath,
    required String fileType,
    required int fileSize,
  }) async {
    // If this is the first resume or set as default
    final existingResumes = await getAllResumes();
    final isFirstResume = existingResumes.isEmpty;

    // Create the resume record
    final resume = LocalResume(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      title: title,
      filePath: filePath,
      fileType: fileType,
      fileSize: fileSize,
      createdAt: DateTime.now(),
      isDefault: isFirstResume,
    );

    final prefs = _isarService.prefs;
    final resumesJson = prefs.getStringList('local_resumes') ?? <String>[]
      ..add(jsonEncode(resume.toJson()));
    await prefs.setStringList('local_resumes', resumesJson);

    return resume;
  }

  /// Copy a file to app directory and create resume record
  /// Returns the created LocalResume
  Future<LocalResume> addResumeFromFile(File file) async {
    // Get app documents directory
    final appDir = await getApplicationDocumentsDirectory();
    final resumeDir = Directory('${appDir.path}/resumes');
    await resumeDir.create(recursive: true);

    // Generate unique filename
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = file.path.split('.').last;
    final fileName = 'resume_$timestamp.$extension';
    final newFilePath = '${resumeDir.path}/$fileName';

    // Copy file to app directory
    await file.copy(newFilePath);

    // Get file info
    final newFile = File(newFilePath);
    final fileSize = await newFile.length();
    final fileType = extension.toUpperCase();

    return addResume(
      name: fileName,
      title: _extractTitleFromFileName(fileName),
      filePath: newFilePath,
      fileType: fileType,
      fileSize: fileSize,
    );
  }

  /// Delete a resume
  /// Returns true if successful
  Future<bool> deleteResume(String id) async {
    final resume = await getResumeById(id);
    if (resume == null) return false;

    // Delete the file from storage
    final file = File(resume.filePath);
    if (await file.exists()) {
      await file.delete();
    }

    // Delete from storage
    final prefs = _isarService.prefs;
    final resumesJson = prefs.getStringList('local_resumes') ?? <String>[]
      ..removeWhere((jsonStr) {
        final resumeData = jsonDecode(jsonStr) as Map<String, dynamic>;
        return resumeData['id'] == id;
      });
    await prefs.setStringList('local_resumes', resumesJson);

    return true;
  }

  /// Set a resume as default
  /// If setDefault is true, makes this the only default resume
  /// If setDefault is false, removes default status
  Future<void> setDefaultResume(String id, {bool setDefault = true}) async {
    final prefs = _isarService.prefs;
    final resumesJson = prefs.getStringList('local_resumes') ?? <String>[];

    final updatedResumes = resumesJson.map((jsonStr) {
      final resumeData = jsonDecode(jsonStr) as Map<String, dynamic>;
      if (resumeData['id'] == id) {
        resumeData['isDefault'] = setDefault;
      } else if (setDefault) {
        resumeData['isDefault'] = false;
      }
      return jsonEncode(resumeData);
    }).toList();

    await prefs.setStringList('local_resumes', updatedResumes);
  }

  /// Duplicate a resume
  /// Returns the duplicated LocalResume
  Future<LocalResume> duplicateResume(String id) async {
    final original = await getResumeById(id);
    if (original == null) {
      throw Exception('Resume not found');
    }

    // Read the original file
    final originalFile = File(original.filePath);
    if (!await originalFile.exists()) {
      throw Exception('Original file not found');
    }

    // Create new file path
    final appDir = await getApplicationDocumentsDirectory();
    final resumeDir = Directory('${appDir.path}/resumes');
    await resumeDir.create(recursive: true);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = original.filePath.split('.').last;
    final newFileName =
        'resume_${original.name.split('.').first}_copy_$timestamp.$extension';
    final newFilePath = '${resumeDir.path}/$newFileName';

    // Copy file
    await originalFile.copy(newFilePath);

    // Create new resume record
    final copy = LocalResume(
      id: timestamp.toString(),
      name: newFileName,
      title: '${original.title} (Copy)',
      filePath: newFilePath,
      fileType: original.fileType,
      fileSize: original.fileSize,
      createdAt: DateTime.now(),
    );

    final prefs = _isarService.prefs;
    final resumesJson = prefs.getStringList('local_resumes') ?? <String>[]
      ..add(jsonEncode(copy.toJson()));
    await prefs.setStringList('local_resumes', resumesJson);

    return copy;
  }

  /// Rename a resume
  /// Returns the updated LocalResume
  Future<LocalResume> renameResume(String id, String newName) async {
    final prefs = _isarService.prefs;
    final resumesJson = prefs.getStringList('local_resumes') ?? <String>[]
      ..removeWhere((jsonStr) {
        final resumeData = jsonDecode(jsonStr) as Map<String, dynamic>;
        return resumeData['id'] == id;
      });

    final updatedResumes = <String>[];
    LocalResume? updatedResume;

    for (final jsonStr in resumesJson) {
      final resumeData = jsonDecode(jsonStr) as Map<String, dynamic>;
      if (resumeData['id'] == id) {
        resumeData['name'] = newName;
        resumeData['title'] = _extractTitleFromFileName(newName);
        updatedResume = LocalResume.fromJson(resumeData);
        updatedResumes.add(jsonEncode(resumeData));
      } else {
        updatedResumes.add(jsonStr);
      }
    }

    await prefs.setStringList('local_resumes', updatedResumes);

    if (updatedResume == null) {
      throw Exception('Resume not found');
    }

    return updatedResume;
  }

  /// Clear all resumes
  Future<void> clearAllResumes() async {
    // Delete all files
    final resumes = await getAllResumes();
    for (final resume in resumes) {
      final file = File(resume.filePath);
      if (await file.exists()) {
        await file.delete();
      }
    }

    // Clear storage
    final prefs = _isarService.prefs;
    await prefs.remove('local_resumes');
  }

  /// Get the default resume
  Future<LocalResume?> getDefaultResume() async {
    final resumes = await getAllResumes();
    try {
      return resumes.firstWhere((resume) => resume.isDefault);
    } catch (e) {
      return null;
    }
  }

  /// Extract title from file name
  String _extractTitleFromFileName(String fileName) {
    // Remove file extension
    final nameWithoutExt = fileName.split('.').first;
    // Capitalize
    return nameWithoutExt
        .split('_')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
              : word,
        )
        .join(' ');
  }
}

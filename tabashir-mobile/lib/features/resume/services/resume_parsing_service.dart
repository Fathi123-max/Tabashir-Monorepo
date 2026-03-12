import 'dart:io';

abstract class ResumeParsingService {
  Future<Map<String, dynamic>> parseResumeFile(File file, String fileName);
  Future<Map<String, dynamic>> parseResumeFromText(String resumeText);
}

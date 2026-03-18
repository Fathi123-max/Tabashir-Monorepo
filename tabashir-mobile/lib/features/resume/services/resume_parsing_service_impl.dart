import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/services/file_service.dart';
import 'package:tabashir/core/network/models/raw_cv_input.dart';
import 'package:tabashir/core/network/services/job/tabashir_api_service.dart';
import 'package:tabashir/features/resume/services/resume_parsing_service.dart';
import 'package:tabashir/features/resume/services/resume_text_extractor.dart';

/// Implementation of ResumeParsingService
/// Uses TabashirApiService to parse CV files and text
@Injectable(as: ResumeParsingService)
class ResumeParsingServiceImpl implements ResumeParsingService {
  ResumeParsingServiceImpl(
    this._fileService,
    this._tabashirApiService,
  );

  final FileService _fileService;
  final TabashirApiService _tabashirApiService;

  @override
  Future<Map<String, dynamic>> parseResumeFile(
    File file,
    String fileName,
  ) async {
    try {
      print('🔧 [RESUME_PARSING] Parsing file: $fileName');

      // Check file type by extension
      final isPdf = fileName.toLowerCase().endsWith('.pdf');
      final isDoc = fileName.toLowerCase().endsWith('.doc');
      final isDocx = fileName.toLowerCase().endsWith('.docx');
      final isText = fileName.toLowerCase().endsWith('.txt');

      // For text files, parse as text
      if (isText) {
        print('🔧 [RESUME_PARSING] Text file detected - parsing as text');
        final fileBytes = await file.readAsBytes();
        final fileContent = utf8.decode(fileBytes);
        return await _parseResumeContent(fileContent);
      }

      // For binary files (PDF, DOC, DOCX), prefer client-side extraction first
      if (isPdf || isDoc || isDocx) {
        print(
          '🔧 [RESUME_PARSING] Binary file detected - attempting local extraction',
        );
        final extractedText = await ResumeTextExtractor.extractText(file);
        if (extractedText.isNotEmpty) {
          print(
            '🟢 [RESUME_PARSING] Local extraction successful, sending raw text',
          );
          return await _parseResumeContent(extractedText);
        }

        print(
          '⚠️ [RESUME_PARSING] Local extraction returned empty text - falling back to backend parsing',
        );
        return await _parseResumeFromFile(file);
      }

      // For unknown file types, return empty data
      print(
        '⚠️ [RESUME_PARSING] Unknown file type - returning empty parsed data',
      );
      return _getEmptyParsedData();
    } catch (e) {
      // If parsing fails, return empty data instead of throwing
      // This allows the file upload to proceed even if parsing fails
      print('⚠️ [RESUME_PARSING] Failed to parse resume file: $e');
      print(
        '⚠️ [RESUME_PARSING] Returning empty parsed data (file will still be uploaded)',
      );
      return _getEmptyParsedData();
    }
  }

  @override
  Future<Map<String, dynamic>> parseResumeFromText(String resumeText) async {
    try {
      return await _parseResumeContent(resumeText);
    } catch (e) {
      throw Exception('Failed to parse resume text: $e');
    }
  }

  /// Parse resume content using TabashirApiService
  Future<Map<String, dynamic>> _parseResumeContent(String content) async {
    try {
      // Get current user ID for the request - use a simple approach
      // since AuthSessionService doesn't expose userId directly
      final token = await AuthSessionService.instance.accessToken;
      final userId = token != null ? 'mobile_user' : 'anonymous';

      // Create request with user_id
      final request = RawCVInput(
        userId: userId,
        rawData: content,
      );

      // Call API
      final response = await _tabashirApiService.formatCVFromRaw(request);

      // Log full response for debugging
      final responseJson = jsonEncode(response.data);
      print('🔍 [RESUME_PARSING] START FULL RESPONSE');
      // Print in chunks of 800 characters to avoid console truncation
      for (var i = 0; i < responseJson.length; i += 800) {
        print(
          responseJson.substring(
            i,
            i + 800 > responseJson.length ? responseJson.length : i + 800,
          ),
        );
      }
      print('🔍 [RESUME_PARSING] END FULL RESPONSE');

      dev.log(
        'Full response from format-cv-object: $responseJson',
        name: 'RESUME_PARSING',
      );

      // Check if response is successful
      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        // The backend returns FormattedCVResponse with 'formatted_resume' field
        final formattedResume = response.data.formattedResume;

        if (formattedResume.isNotEmpty) {
          // Map the backend's actual response structure
          return _mapBackendResponseToMap(formattedResume);
        } else {
          // If formatted_resume is empty, return empty data
          return _getEmptyParsedData();
        }
      } else {
        throw Exception(
          'Failed to parse resume. Status: ${response.response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('CV parsing failed: $e');
    }
  }

  /// Parse resume from binary file using TabashirApiService
  Future<Map<String, dynamic>> _parseResumeFromFile(File file) async {
    try {
      // Get file name
      final fileName = file.path.split('/').last;

      // Create multipart file
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      );

      // Call formatCV API (it returns binary DOCX file)
      final response = await _tabashirApiService.formatCV(
        multipartFile,
        null, // outputLanguage
      );

      // Check if response is successful
      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        // Download and save the formatted CV
        final bytes = response.data;
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = 'formatted_resume_$timestamp.docx';
        await _fileService.saveFile(
          fileName: fileName,
          bytes: Uint8List.fromList(bytes),
        );

        print('✅ [RESUME_PARSING] Successfully formatted CV: $fileName');
        return _getEmptyParsedData(parsed: true);
      } else {
        throw Exception(
          'Failed to parse resume. Status: ${response.response.statusCode}',
        );
      }
    } catch (e) {
      // If parsing fails, return empty data instead of throwing
      // This allows the file upload to proceed even if parsing fails
      print('⚠️ [RESUME_PARSING] Failed to parse binary file: $e');
      print(
        '⚠️ [RESUME_PARSING] Returning empty parsed data (file will still be uploaded)',
      );
      return _getEmptyParsedData();
    }
  }

  /// Map backend response (formatted_resume) to the expected format
  Map<String, dynamic> _mapBackendResponseToMap(
    Map<String, dynamic> formattedResume,
  ) {
    final header = formattedResume['header'] as Map<String, dynamic>? ?? {};
    final personalInfo =
        formattedResume['personalInfo'] as Map<String, dynamic>? ?? {};

    // Extract personal info - Align with Resume model (fullName)
    final name =
        (header['name'] as String? ?? personalInfo['fullName'] as String? ?? '')
            .trim();
    final email =
        (header['email'] as String? ?? personalInfo['email'] as String? ?? '')
            .trim();
    final phone =
        (header['phone'] as String? ?? personalInfo['phone'] as String? ?? '')
            .trim();
    final location =
        (header['location'] as String? ??
                personalInfo['address'] as String? ??
                personalInfo['location'] as String? ??
                '')
            .trim();
    final nationality = (header['nationality'] as String? ?? '').trim();

    // Extract objective as summary
    final summary = (formattedResume['objective'] as String? ?? '').trim();

    // Extract and combine skills
    final keywords =
        (formattedResume['keywords'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    final skillsObj = formattedResume['skills'] as Map<String, dynamic>? ?? {};
    final skillset =
        (skillsObj['skillset'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final softskills =
        (skillsObj['softskills'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final training =
        (skillsObj['training'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    final allSkills =
        [
              ...keywords,
              ...skillset,
              ...softskills,
              ...training,
            ]
            .map((s) => s.replaceAll(RegExp('^- '), '').trim())
            .where((s) => s.isNotEmpty)
            .toSet()
            .toList();

    // Mapping to Skill model structure
    final skillObjects = allSkills
        .map(
          (s) => {
            'name': s,
            'level': 'intermediate',
            'category': 'Technical',
          },
        )
        .toList();

    // Combine work and leadership
    final workList = formattedResume['work'] as List<dynamic>? ?? [];
    final leadershipList =
        formattedResume['leadership'] as List<dynamic>? ?? [];

    final combinedWork = [...workList, ...leadershipList];
    final experience = combinedWork
        .whereType<Map<String, dynamic>>()
        .map(
          (exp) {
            final dateStr = (exp['date'] as String? ?? '').trim();
            final dates = _parseDateRange(dateStr);

            return {
              'company': (exp['company'] as String? ?? '').trim(),
              'position': (exp['position'] as String? ?? '').trim(),
              'location': (exp['location'] as String? ?? '').trim(),
              'startDate': dates['start']?.toIso8601String() ?? '',
              'endDate': dates['end']?.toIso8601String() ?? '',
              'isCurrent': dateStr.toLowerCase().contains('present'),
              'description':
                  (exp['details'] as List<dynamic>?)
                      ?.map((d) => d.toString())
                      .join('\n')
                      .trim() ??
                  '',
            };
          },
        )
        .where(
          (exp) {
            final company = exp['company'];
            final position = exp['position'];
            return (company != null && company.toString().isNotEmpty) ||
                (position != null && position.toString().isNotEmpty);
          },
        )
        .toList();

    // Extract education
    final educationList = formattedResume['education'] as List<dynamic>? ?? [];
    final education = educationList
        .whereType<Map<String, dynamic>>()
        .map(
          (edu) {
            final dateStr = (edu['date'] as String? ?? '').trim();
            final dates = _parseDateRange(dateStr);

            return {
              'institution': (edu['university'] as String? ?? '').trim(),
              'degree': (edu['degree'] as String? ?? '').trim(),
              'fieldOfStudy': (edu['major'] as String? ?? '').trim(),
              'startDate': dates['start']?.toIso8601String() ?? '',
              'endDate': dates['end']?.toIso8601String() ?? '',
              'year': dateStr, // Keep original string for display
              'location': (edu['location'] as String? ?? '').trim(),
              'gpa': (edu['_gpa'] as String? ?? '').trim(),
              'description':
                  (edu['details'] as List<dynamic>?)
                      ?.map((d) => d.toString())
                      .join('\n')
                      .trim() ??
                  '',
            };
          },
        )
        .where(
          (edu) {
            final institution = edu['institution'];
            final degree = edu['degree'];
            return (institution != null && institution.isNotEmpty) ||
                (degree != null && degree.isNotEmpty);
          },
        )
        .toList();

    // Extract languages
    final languages =
        (formattedResume['languages'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    // Extract projects
    final projectsList = formattedResume['projects'] as List<dynamic>? ?? [];
    final projects = projectsList
        .whereType<Map<String, dynamic>>()
        .map(
          (proj) => {
            'title': (proj['title'] as String? ?? '').trim(),
            'position': (proj['position'] as String? ?? '').trim(),
            'description':
                (proj['details'] as List<dynamic>?)
                    ?.map((d) => d.toString())
                    .join('\n')
                    .trim() ??
                '',
            'link': '',
          },
        )
        .toList();

    // Extract other links
    final github = (header['github'] as String? ?? '').trim();
    final linkedin = (header['linkedin'] as String? ?? '').trim();

    return {
      'fullName': name, // Preferred key for Resume model
      'name': name, // Keep name for compatibility
      'email': email,
      'phone': phone,
      'address': location,
      'location': location, // Dual compatibility
      'nationality': nationality,
      'summary': summary,
      'keywords': (formattedResume['keywords'] as List? ?? []).cast<String>(),
      'skills': allSkills, // Flat list for chips
      'skillObjects': skillObjects, // For Resume model
      'experience': experience,
      'leadership': (formattedResume['leadership'] as List? ?? []),
      'education': education,
      'languages': languages,
      'projects': projects,
      'github': github,
      'linkedin': linkedin,
      'rawResponse': formattedResume, // Store the entire object for "later use"
    };
  }

  /// Return empty parsed data structure
  /// Used when parsing fails or for binary files
  Map<String, dynamic> _getEmptyParsedData({bool parsed = false}) => {
    'fullName': '',
    'name': '',
    'email': '',
    'phone': '',
    'address': '',
    'nationality': '',
    'summary': '',
    'skills': <String>[],
    'experience': <Map<String, dynamic>>[],
    'education': <Map<String, dynamic>>[],
    'projects': <Map<String, dynamic>>[],
    'parsed': parsed, // Indicates if parsing was successful
  };

  /// Helper to parse date ranges like "Aug 2024 - Nov 2024" or "2017 - 2021"
  Map<String, DateTime?> _parseDateRange(String dateStr) {
    if (dateStr.isEmpty) return {'start': null, 'end': null};

    try {
      final parts = dateStr.split(RegExp(r'\s*[-–—]\s*'));
      DateTime? start;
      DateTime? end;

      if (parts.isNotEmpty) {
        start = _parseSingleDate(parts[0]);
      }
      if (parts.length > 1) {
        if (parts[1].toLowerCase().contains('present')) {
          end = DateTime.now();
        } else {
          end = _parseSingleDate(parts[1]);
        }
      }

      return {'start': start, 'end': end};
    } catch (_) {
      return {'start': null, 'end': null};
    }
  }

  /// Attempts to parse various date formats into DateTime
  DateTime? _parseSingleDate(String date) {
    final cleaned = date.trim();
    if (cleaned.isEmpty) return null;

    // Try full year (2021)
    if (RegExp(r'^\d{4}$').hasMatch(cleaned)) {
      return DateTime(int.parse(cleaned));
    }

    // Try Month Year (Aug 2024)
    final monthYearMatch = RegExp(
      r'^([a-zA-Z]+)\s+(\d{4})$',
    ).firstMatch(cleaned);
    if (monthYearMatch != null) {
      final monthStr = monthYearMatch.group(1)!.toLowerCase();
      final year = int.parse(monthYearMatch.group(2)!);
      final month = _monthToNumber(monthStr);
      return DateTime(year, month);
    }

    return DateTime.tryParse(cleaned);
  }

  int _monthToNumber(String month) {
    if (month.startsWith('jan')) return 1;
    if (month.startsWith('feb')) return 2;
    if (month.startsWith('mar')) return 3;
    if (month.startsWith('apr')) return 4;
    if (month.startsWith('may')) return 5;
    if (month.startsWith('jun')) return 6;
    if (month.startsWith('jul')) return 7;
    if (month.startsWith('aug')) return 8;
    if (month.startsWith('sep')) return 9;
    if (month.startsWith('oct')) return 10;
    if (month.startsWith('nov')) return 11;
    if (month.startsWith('dec')) return 12;
    return 1;
  }
}

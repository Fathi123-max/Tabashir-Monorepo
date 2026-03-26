import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/network/models/ai_resume/create_ai_resume_request.dart';
import 'package:tabashir/core/network/models/ai_resume/create_ai_resume_response.dart';
import 'package:tabashir/core/network/services/ai_resume/ai_resume_api_service.dart';
import 'package:tabashir/core/services/isar_service.dart';
import 'package:tabashir/core/network/models/ai_resume/resume_models.dart';
import 'package:tabashir/features/ai_resume_builder/domain/repositories/ai_resume_builder_repository.dart';

/// Implementation of AiResumeBuilderRepository
@Injectable(as: AiResumeBuilderRepository)
class AiResumeBuilderRepositoryImpl implements AiResumeBuilderRepository {
  AiResumeBuilderRepositoryImpl(
    this._isarService,
    this._aiResumeApiService,
  );

  final IsarService _isarService;
  final AiResumeApiService _aiResumeApiService;
  static const String _resumeDataKey = 'ai_resume_builder_resume_data';

  @override
  Future<void> saveResumeData(ResumeData resumeData) async {
    try {
      final jsonString = jsonEncode(resumeData.toJson());
      await _isarService.prefs.setString(_resumeDataKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save resume data: $e');
    }
  }

  @override
  Future<ResumeData?> getResumeData() async {
    try {
      final jsonString = _isarService.prefs.getString(_resumeDataKey);
      if (jsonString == null) {
        return null;
      }
      final json = jsonDecode(jsonString);
      return ResumeData.fromJson(json as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to load resume data: $e');
    }
  }

  @override
  Future<void> updateCurrentStep(int step) async {
    try {
      final existingData = await getResumeData();
      final updatedData = existingData != null
          ? existingData.copyWith(currentStep: step)
          : ResumeData(currentStep: step);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to update current step: $e');
    }
  }

  @override
  Future<void> updateResumeScore(int score) async {
    try {
      final existingData = await getResumeData();
      final updatedData = existingData != null
          ? existingData.copyWith(resumeScore: score)
          : ResumeData(resumeScore: score);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to update resume score: $e');
    }
  }

  @override
  Future<void> updatePersonalDetails(PersonalDetails personalDetails) async {
    try {
      final existingData = await getResumeData();
      final updatedData = existingData != null
          ? existingData.copyWith(personalDetails: personalDetails)
          : ResumeData(personalDetails: personalDetails);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to update personal details: $e');
    }
  }

  @override
  Future<void> updateProfessionalSummary(ProfessionalSummary summary) async {
    try {
      final existingData = await getResumeData();
      final updatedData = existingData != null
          ? existingData.copyWith(professionalSummary: summary)
          : ResumeData(professionalSummary: summary);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to update professional summary: $e');
    }
  }

  @override
  Future<void> addWorkExperience(WorkExperience experience) async {
    try {
      final existingData = await getResumeData() ?? const ResumeData();
      final experiences = List<WorkExperience>.from(existingData.workExperience)
        ..add(experience);
      final updatedData = existingData.copyWith(workExperience: experiences);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to add work experience: $e');
    }
  }

  @override
  Future<void> updateWorkExperience(
    int index,
    WorkExperience experience,
  ) async {
    try {
      final existingData = await getResumeData();
      if (existingData == null) {
        throw Exception('No existing resume data found');
      }
      final experiences = List<WorkExperience>.from(
        existingData.workExperience,
      );
      if (index < 0 || index >= experiences.length) {
        throw Exception('Invalid work experience index: $index');
      }
      experiences[index] = experience;
      final updatedData = existingData.copyWith(workExperience: experiences);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to update work experience: $e');
    }
  }

  @override
  Future<void> removeWorkExperience(int index) async {
    try {
      final existingData = await getResumeData();
      if (existingData == null) {
        throw Exception('No existing resume data found');
      }
      final experiences = List<WorkExperience>.from(
        existingData.workExperience,
      );
      if (index < 0 || index >= experiences.length) {
        throw Exception('Invalid work experience index: $index');
      }
      experiences.removeAt(index);
      final updatedData = existingData.copyWith(workExperience: experiences);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to remove work experience: $e');
    }
  }

  @override
  Future<void> addEducation(Education education) async {
    try {
      final existingData = await getResumeData() ?? const ResumeData();
      final educationList = List<Education>.from(existingData.education)
        ..add(education);
      final updatedData = existingData.copyWith(education: educationList);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to add education: $e');
    }
  }

  @override
  Future<void> updateEducation(int index, Education education) async {
    try {
      final existingData = await getResumeData();
      if (existingData == null) {
        throw Exception('No existing resume data found');
      }
      final educationList = List<Education>.from(existingData.education);
      if (index < 0 || index >= educationList.length) {
        throw Exception('Invalid education index: $index');
      }
      educationList[index] = education;
      final updatedData = existingData.copyWith(education: educationList);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to update education: $e');
    }
  }

  @override
  Future<void> removeEducation(int index) async {
    try {
      final existingData = await getResumeData();
      if (existingData == null) {
        throw Exception('No existing resume data found');
      }
      final educationList = List<Education>.from(existingData.education);
      if (index < 0 || index >= educationList.length) {
        throw Exception('Invalid education index: $index');
      }
      educationList.removeAt(index);
      final updatedData = existingData.copyWith(education: educationList);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to remove education: $e');
    }
  }

  @override
  Future<void> addSkill(Skill skill) async {
    try {
      final existingData = await getResumeData() ?? const ResumeData();
      final skills = List<Skill>.from(existingData.skills)..add(skill);
      final updatedData = existingData.copyWith(skills: skills);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to add skill: $e');
    }
  }

  @override
  Future<void> updateSkill(int index, Skill skill) async {
    try {
      final existingData = await getResumeData();
      if (existingData == null) {
        throw Exception('No existing resume data found');
      }
      final skills = List<Skill>.from(existingData.skills);
      if (index < 0 || index >= skills.length) {
        throw Exception('Invalid skill index: $index');
      }
      skills[index] = skill;
      final updatedData = existingData.copyWith(skills: skills);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to update skill: $e');
    }
  }

  @override
  Future<void> removeSkill(int index) async {
    try {
      final existingData = await getResumeData();
      if (existingData == null) {
        throw Exception('No existing resume data found');
      }
      final skills = List<Skill>.from(existingData.skills);
      if (index < 0 || index >= skills.length) {
        throw Exception('Invalid skill index: $index');
      }
      skills.removeAt(index);
      final updatedData = existingData.copyWith(skills: skills);
      await saveResumeData(updatedData);
    } catch (e) {
      throw Exception('Failed to remove skill: $e');
    }
  }

  @override
  Future<void> clearResumeData() async {
    try {
      await _isarService.prefs.remove(_resumeDataKey);
    } catch (e) {
      throw Exception('Failed to clear resume data: $e');
    }
  }

  @override
  Future<bool> hasResumeData() async {
    try {
      final data = await getResumeData();
      return data != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<CreateAiResumeData?> generateAiResume() async {
    try {
      final resumeData = await getResumeData();
      if (resumeData == null) {
        throw Exception('No resume data found');
      }

      // Convert ResumeData to API request format
      final request = _createApiRequestFromResumeData(resumeData);

      // Call AI resume generation API
      final response = await _aiResumeApiService.createAiResume(request);

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        return response.data.data;
      } else {
        throw Exception(
          'Failed to generate AI resume. Status: ${response.response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('AI resume generation failed: $e');
    }
  }

  /// Convert ResumeData to CreateAiResumeRequest
  CreateAiResumeRequest _createApiRequestFromResumeData(ResumeData data) {
    // Convert personal details to JSON
    final personalDetailsJson = jsonEncode({
      'fullName': data.personalDetails?.fullName ?? '',
      'email': data.personalDetails?.email ?? '',
      'phone': data.personalDetails?.phoneNumber ?? '',
      'address':
          '${data.personalDetails?.city ?? ''}, ${data.personalDetails?.country ?? ''}',
      'title': data.personalDetails?.fullName ?? '',
    });

    // Convert professional details to JSON
    final professionalDetailsJson = jsonEncode({
      'summary': data.professionalSummary?.summary ?? '',
    });

    // Convert employment history to JSON
    final employmentHistoryJson = jsonEncode(
      data.workExperience
          .map(
            (exp) => {
              'company': exp.organization,
              'position': exp.position,
              'startDate': exp.startDate?.toIso8601String() ?? '',
              'endDate': exp.endDate?.toIso8601String(),
              'isCurrent': exp.isPresent,
              'description': exp.keyTasks ?? '',
              'location': exp.city ?? '',
            },
          )
          .toList(),
    );

    // Convert education to JSON
    final educationJson = jsonEncode(
      data.education
          .map(
            (edu) => {
              'institution': edu.school,
              'degree': edu.degree,
              'fieldOfStudy': edu.description ?? '',
              'startDate': edu.startDate?.toIso8601String() ?? '',
              'endDate': edu.endDate?.toIso8601String(),
              'gpa': '',
            },
          )
          .toList(),
    );

    // Convert skills to JSON
    final skillsJson = jsonEncode(
      data.skills
          .map(
            (skill) => {
              'name': skill.name,
              'level': skill.proficiency?.name ?? '',
              'category': skill.category?.name ?? '',
            },
          )
          .toList(),
    );

    // Convert languages to JSON
    final languagesJson = jsonEncode(
      data.skills
          .where((s) => s.category == SkillCategory.languages)
          .map((skill) => skill.name)
          .toList(),
    );

    return CreateAiResumeRequest(
      personalDetailsJson: personalDetailsJson,
      professionalDetailsJson: professionalDetailsJson,
      employmentHistoryJson: employmentHistoryJson,
      educationJson: educationJson,
      skillsJson: skillsJson,
      languagesJson: languagesJson,
    );
  }
}

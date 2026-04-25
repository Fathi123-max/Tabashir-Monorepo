import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/local_persistence_service.dart';
import 'package:tabashir/features/resume/data/models/resume_model.dart';
import 'package:tabashir/features/resume/domain/repositories/resume_repository.dart';

/// Implementation of ResumeRepository
/// For structured resume data (local storage)
@Injectable(as: ResumeRepository)
class ResumeRepositoryImpl implements ResumeRepository {
  ResumeRepositoryImpl(
    this._persistenceService,
  );

  final LocalPersistenceService _persistenceService;
  static const String _resumesKey = 'resumes_data';

  @override
  Future<Resume> getResume({
    required String resumeId,
  }) async {
    try {
      final jsonString = _persistenceService.prefs.getString('resume_$resumeId');
      if (jsonString == null) {
        throw Exception('Resume not found');
      }
      final json = jsonDecode(jsonString);
      return Resume.fromJson(json as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to get resume: $e');
    }
  }

  @override
  Future<List<Resume>> getUserResumes({
    required String userId,
  }) async {
    try {
      final resumes = <Resume>[];
      final prefs = _persistenceService.prefs;

      for (final key in prefs.getKeys()) {
        if (key.startsWith('resume_')) {
          final jsonString = prefs.getString(key);
          if (jsonString != null) {
            final json = jsonDecode(jsonString);
            final resume = Resume.fromJson(json as Map<String, dynamic>);
            if (resume.userId == userId) {
              resumes.add(resume);
            }
          }
        }
      }

      return resumes;
    } catch (e) {
      throw Exception('Failed to get user resumes: $e');
    }
  }

  @override
  Future<Resume> createResume({
    required Resume resume,
  }) async {
    try {
      final jsonString = jsonEncode(resume.toJson());
      await _persistenceService.prefs.setString('resume_${resume.id}', jsonString);
      return resume;
    } catch (e) {
      throw Exception('Failed to create resume: $e');
    }
  }

  @override
  Future<Resume> updateResume({
    required String resumeId,
    required Resume resume,
  }) async {
    try {
      final jsonString = jsonEncode(resume.toJson());
      await _persistenceService.prefs.setString('resume_$resumeId', jsonString);
      return resume;
    } catch (e) {
      throw Exception('Failed to update resume: $e');
    }
  }

  @override
  Future<void> deleteResume({
    required String resumeId,
  }) async {
    try {
      await _persistenceService.prefs.remove('resume_$resumeId');
    } catch (e) {
      throw Exception('Failed to delete resume: $e');
    }
  }

  @override
  Future<Resume> duplicateResume({
    required String resumeId,
    String? newTitle,
  }) async {
    try {
      final originalResume = await getResume(resumeId: resumeId);

      final duplicatedResume = originalResume.copyWith(
        id: '${originalResume.id}_copy_${DateTime.now().millisecondsSinceEpoch}',
        title: newTitle ?? '${originalResume.title} (Copy)',
      );

      final jsonString = jsonEncode(duplicatedResume.toJson());
      await _persistenceService.prefs.setString(
        'resume_${duplicatedResume.id}',
        jsonString,
      );

      return duplicatedResume;
    } catch (e) {
      throw Exception('Failed to duplicate resume: $e');
    }
  }

  @override
  Future<String> exportResumeToPdf({
    required String resumeId,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);

      // Convert resume to text format for API
      final resumeText = _convertResumeToText(resume);

      // In a real implementation, you would send the text to the API
      // For now, we'll use the formatCVFromRaw endpoint
      // The API will return a formatted CV (PDF or structured format)

      // This is a placeholder - in a real implementation, you might:
      // 1. Send resume data to a formatting API
      // 2. Get back a PDF or document URL
      // 3. Return the download URL

      return 'Formatted CV for: ${resume.title}';
    } catch (e) {
      throw Exception('Failed to export resume to PDF: $e');
    }
  }

  @override
  Future<String> exportResumeToWord({
    required String resumeId,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);

      // Convert resume to text format for API
      final resumeText = _convertResumeToText(resume);

      // Similar to PDF export, this would use an API to generate Word document
      return 'Word document for: ${resume.title}';
    } catch (e) {
      throw Exception('Failed to export resume to Word: $e');
    }
  }

  /// Convert Resume object to text format for API processing
  String _convertResumeToText(Resume resume) {
    final buffer = StringBuffer();

    // Personal Information
    buffer.writeln(resume.fullName);
    if (resume.email.isNotEmpty) buffer.writeln('Email: ${resume.email}');
    if (resume.phone != null && resume.phone!.isNotEmpty) {
      buffer.writeln('Phone: ${resume.phone}');
    }
    buffer.writeln();

    // Professional Summary
    if (resume.summary != null && resume.summary!.isNotEmpty) {
      buffer.writeln('Professional Summary:');
      buffer.writeln(resume.summary);
      buffer.writeln();
    }

    // Work Experience
    if (resume.experience.isNotEmpty) {
      buffer.writeln('Work Experience:');
      for (final exp in resume.experience) {
        buffer.writeln('${exp.position} at ${exp.company}');
        buffer.writeln(
          '${_formatDate(exp.startDate)}${exp.isCurrent ? ' - Present' : ' - ${_formatDate(exp.endDate)}'}',
        );
        if (exp.description != null && exp.description!.isNotEmpty) {
          buffer.writeln(exp.description);
        }
        buffer.writeln();
      }
    }

    // Education
    if (resume.education.isNotEmpty) {
      buffer.writeln('Education:');
      for (final edu in resume.education) {
        buffer.writeln('${edu.degree} - ${edu.institution}');
        buffer.writeln(
          '${_formatDate(edu.startDate)} - ${_formatDate(edu.endDate)}',
        );
        if (edu.fieldOfStudy != null && edu.fieldOfStudy!.isNotEmpty) {
          buffer.writeln('Field of Study: ${edu.fieldOfStudy}');
        }
        buffer.writeln();
      }
    }

    // Skills
    if (resume.skills.isNotEmpty) {
      buffer.writeln('Skills:');
      for (final skill in resume.skills) {
        buffer.writeln('${skill.name} (${skill.level.name})');
      }
      buffer.writeln();
    }

    // Certifications
    if (resume.certifications.isNotEmpty) {
      buffer.writeln('Certifications:');
      for (final cert in resume.certifications) {
        buffer.writeln('• $cert');
      }
      buffer.writeln();
    }

    // Languages
    if (resume.languages.isNotEmpty) {
      buffer.writeln('Languages:');
      for (final lang in resume.languages) {
        buffer.writeln('• $lang');
      }
      buffer.writeln();
    }

    return buffer.toString();
  }

  /// Format Date for display
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.year}';
  }

  @override
  Future<String> translateResume({
    required String resumeId,
    required String targetLanguage,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);

      // Convert resume to text format
      final resumeText = _convertResumeToText(resume);

      // In a real implementation, you would:
      // 1. Send the text to the translation API
      // 2. Get back the translated text
      // 3. Optionally format it as a new resume or document

      // For now, this is a placeholder
      // You would use the TabashirApiService.translateCV endpoint here

      return 'Translated resume to $targetLanguage';
    } catch (e) {
      throw Exception('Failed to translate resume: $e');
    }
  }

  @override
  Future<void> addWorkExperience({
    required String resumeId,
    required WorkExperience experience,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);
      final experienceList = List<WorkExperience>.from(resume.experience)
        ..add(experience);
      final updatedResume = resume.copyWith(experience: experienceList);
      await updateResume(resumeId: resumeId, resume: updatedResume);
    } catch (e) {
      throw Exception('Failed to add work experience: $e');
    }
  }

  @override
  Future<void> updateWorkExperience({
    required String resumeId,
    required int index,
    required WorkExperience experience,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);
      if (index < 0 || index >= resume.experience.length) {
        throw Exception('Invalid experience index');
      }
      final experienceList = List<WorkExperience>.from(resume.experience);
      experienceList[index] = experience;
      final updatedResume = resume.copyWith(experience: experienceList);
      await updateResume(resumeId: resumeId, resume: updatedResume);
    } catch (e) {
      throw Exception('Failed to update work experience: $e');
    }
  }

  @override
  Future<void> removeWorkExperience({
    required String resumeId,
    required int index,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);
      if (index < 0 || index >= resume.experience.length) {
        throw Exception('Invalid experience index');
      }
      final experienceList = List<WorkExperience>.from(resume.experience);
      experienceList.removeAt(index);
      final updatedResume = resume.copyWith(experience: experienceList);
      await updateResume(resumeId: resumeId, resume: updatedResume);
    } catch (e) {
      throw Exception('Failed to remove work experience: $e');
    }
  }

  @override
  Future<void> addEducation({
    required String resumeId,
    required Education education,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);
      final educationList = List<Education>.from(resume.education)
        ..add(education);
      final updatedResume = resume.copyWith(education: educationList);
      await updateResume(resumeId: resumeId, resume: updatedResume);
    } catch (e) {
      throw Exception('Failed to add education: $e');
    }
  }

  @override
  Future<void> updateEducation({
    required String resumeId,
    required int index,
    required Education education,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);
      if (index < 0 || index >= resume.education.length) {
        throw Exception('Invalid education index');
      }
      final educationList = List<Education>.from(resume.education);
      educationList[index] = education;
      final updatedResume = resume.copyWith(education: educationList);
      await updateResume(resumeId: resumeId, resume: updatedResume);
    } catch (e) {
      throw Exception('Failed to update education: $e');
    }
  }

  @override
  Future<void> removeEducation({
    required String resumeId,
    required int index,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);
      if (index < 0 || index >= resume.education.length) {
        throw Exception('Invalid education index');
      }
      final educationList = List<Education>.from(resume.education);
      educationList.removeAt(index);
      final updatedResume = resume.copyWith(education: educationList);
      await updateResume(resumeId: resumeId, resume: updatedResume);
    } catch (e) {
      throw Exception('Failed to remove education: $e');
    }
  }

  @override
  Future<void> addSkill({
    required String resumeId,
    required Skill skill,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);
      final skills = List<Skill>.from(resume.skills)..add(skill);
      final updatedResume = resume.copyWith(skills: skills);
      await updateResume(resumeId: resumeId, resume: updatedResume);
    } catch (e) {
      throw Exception('Failed to add skill: $e');
    }
  }

  @override
  Future<void> updateSkill({
    required String resumeId,
    required int index,
    required Skill skill,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);
      if (index < 0 || index >= resume.skills.length) {
        throw Exception('Invalid skill index');
      }
      final skills = List<Skill>.from(resume.skills);
      skills[index] = skill;
      final updatedResume = resume.copyWith(skills: skills);
      await updateResume(resumeId: resumeId, resume: updatedResume);
    } catch (e) {
      throw Exception('Failed to update skill: $e');
    }
  }

  @override
  Future<void> removeSkill({
    required String resumeId,
    required int index,
  }) async {
    try {
      final resume = await getResume(resumeId: resumeId);
      if (index < 0 || index >= resume.skills.length) {
        throw Exception('Invalid skill index');
      }
      final skills = List<Skill>.from(resume.skills);
      skills.removeAt(index);
      final updatedResume = resume.copyWith(skills: skills);
      await updateResume(resumeId: resumeId, resume: updatedResume);
    } catch (e) {
      throw Exception('Failed to remove skill: $e');
    }
  }
}

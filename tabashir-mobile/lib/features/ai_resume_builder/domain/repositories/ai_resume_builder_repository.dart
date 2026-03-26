import 'package:tabashir/core/network/models/ai_resume/create_ai_resume_response.dart';
import 'package:tabashir/core/network/models/ai_resume/resume_models.dart';

/// Repository interface for AI Resume Builder feature
abstract class AiResumeBuilderRepository {
  /// Save resume data locally
  Future<void> saveResumeData(ResumeData resumeData);

  /// Load resume data from local storage
  Future<ResumeData?> getResumeData();

  /// Update current step
  Future<void> updateCurrentStep(int step);

  /// Update resume score
  Future<void> updateResumeScore(int score);

  /// Update personal details
  Future<void> updatePersonalDetails(PersonalDetails personalDetails);

  /// Update professional summary
  Future<void> updateProfessionalSummary(ProfessionalSummary summary);

  /// Add work experience
  Future<void> addWorkExperience(WorkExperience experience);

  /// Update work experience
  Future<void> updateWorkExperience(int index, WorkExperience experience);

  /// Remove work experience
  Future<void> removeWorkExperience(int index);

  /// Add education
  Future<void> addEducation(Education education);

  /// Update education
  Future<void> updateEducation(int index, Education education);

  /// Remove education
  Future<void> removeEducation(int index);

  /// Add skill
  Future<void> addSkill(Skill skill);

  /// Update skill
  Future<void> updateSkill(int index, Skill skill);

  /// Remove skill
  Future<void> removeSkill(int index);

  /// Clear all resume data
  Future<void> clearResumeData();

  /// Check if resume data exists
  Future<bool> hasResumeData();

  /// Generate AI resume from current data
  Future<CreateAiResumeData?> generateAiResume();
}

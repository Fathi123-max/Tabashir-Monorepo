import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/resume_models.dart';

part 'ai_resume_builder_state.dart';
part 'ai_resume_builder_cubit.freezed.dart';

class AiResumeBuilderCubit extends Cubit<AiResumeBuilderState> {
  AiResumeBuilderCubit() : super(const AiResumeBuilderState()) {
    _loadSampleData();
  }

  void updatePersonalDetails(PersonalDetails details) {
    final updatedData = state.resumeData.copyWith(personalDetails: details);
    emit(state.copyWith(resumeData: updatedData));
    _updateResumeScore();
  }

  void updateProfessionalSummary(ProfessionalSummary summary) {
    final updatedData = state.resumeData.copyWith(professionalSummary: summary);
    emit(state.copyWith(resumeData: updatedData));
    _updateResumeScore();
  }

  void addWorkExperience(WorkExperience experience) {
    final updatedList = [...state.resumeData.workExperience, experience];
    final updatedData = state.resumeData.copyWith(workExperience: updatedList);
    emit(state.copyWith(resumeData: updatedData));
    _updateResumeScore();
  }

  void updateWorkExperience(int index, WorkExperience experience) {
    final updatedList = [...state.resumeData.workExperience];
    if (index >= 0 && index < updatedList.length) {
      updatedList[index] = experience;
      final updatedData = state.resumeData.copyWith(
        workExperience: updatedList,
      );
      emit(state.copyWith(resumeData: updatedData));
      _updateResumeScore();
    }
  }

  void removeWorkExperience(int index) {
    final updatedList = [...state.resumeData.workExperience];
    if (index >= 0 && index < updatedList.length) {
      updatedList.removeAt(index);
      final updatedData = state.resumeData.copyWith(
        workExperience: updatedList,
      );
      emit(state.copyWith(resumeData: updatedData));
      _updateResumeScore();
    }
  }

  void addEducation(Education education) {
    final updatedList = [...state.resumeData.education, education];
    final updatedData = state.resumeData.copyWith(education: updatedList);
    emit(state.copyWith(resumeData: updatedData));
    _updateResumeScore();
  }

  void updateEducation(int index, Education education) {
    final updatedList = [...state.resumeData.education];
    if (index >= 0 && index < updatedList.length) {
      updatedList[index] = education;
      final updatedData = state.resumeData.copyWith(education: updatedList);
      emit(state.copyWith(resumeData: updatedData));
      _updateResumeScore();
    }
  }

  void removeEducation(int index) {
    final updatedList = [...state.resumeData.education];
    if (index >= 0 && index < updatedList.length) {
      updatedList.removeAt(index);
      final updatedData = state.resumeData.copyWith(education: updatedList);
      emit(state.copyWith(resumeData: updatedData));
      _updateResumeScore();
    }
  }

  void addSkill(Skill skill) {
    final updatedList = [...state.resumeData.skills, skill];
    final updatedData = state.resumeData.copyWith(skills: updatedList);
    emit(state.copyWith(resumeData: updatedData));
    _updateResumeScore();
  }

  void updateSkill(int index, Skill skill) {
    final updatedList = [...state.resumeData.skills];
    if (index >= 0 && index < updatedList.length) {
      updatedList[index] = skill;
      final updatedData = state.resumeData.copyWith(skills: updatedList);
      emit(state.copyWith(resumeData: updatedData));
      _updateResumeScore();
    }
  }

  void removeSkill(int index) {
    final updatedList = [...state.resumeData.skills];
    if (index >= 0 && index < updatedList.length) {
      updatedList.removeAt(index);
      final updatedData = state.resumeData.copyWith(skills: updatedList);
      emit(state.copyWith(resumeData: updatedData));
      _updateResumeScore();
    }
  }

  void nextStep() {
    final currentStep = state.resumeData.currentStep;
    if (currentStep < BuilderStep.skills) {
      final updatedData = state.resumeData.copyWith(
        currentStep: currentStep + 1,
      );
      emit(state.copyWith(resumeData: updatedData));
    }
  }

  void previousStep() {
    final currentStep = state.resumeData.currentStep;
    if (currentStep > 0) {
      final updatedData = state.resumeData.copyWith(
        currentStep: currentStep - 1,
      );
      emit(state.copyWith(resumeData: updatedData));
    }
  }

  void goToStep(int stepIndex) {
    if (stepIndex >= 0 && stepIndex <= BuilderStep.skills) {
      final updatedData = state.resumeData.copyWith(currentStep: stepIndex);
      emit(state.copyWith(resumeData: updatedData));
    }
  }

  void _updateResumeScore() {
    var score = 0;

    if (state.isPersonalDetailsComplete) {
      score += 20;
    }
    if (state.isProfessionalSummaryComplete) {
      score += 20;
    }
    if (state.isWorkExperienceComplete) {
      score += 20;
    }
    if (state.isEducationComplete) {
      score += 20;
    }
    if (state.isSkillsComplete) {
      score += 20;
    }

    final updatedData = state.resumeData.copyWith(resumeScore: score);
    emit(state.copyWith(resumeData: updatedData));
  }

  bool validateCurrentStep() {
    final currentStep = state.resumeData.currentStep;

    switch (currentStep) {
      case BuilderStep.personalDetails:
        return state.isPersonalDetailsComplete;
      case BuilderStep.professionalSummary:
        return state.isProfessionalSummaryComplete;
      case BuilderStep.workExperience:
        return state.isWorkExperienceComplete;
      case BuilderStep.education:
        return state.isEducationComplete;
      case BuilderStep.skills:
        return state.isSkillsComplete;
      default:
        return false;
    }
  }

  bool canProceedToStep(int stepIndex) {
    // All steps are accessible at the same level
    // Users can navigate to any step directly without completing previous steps
    return true;
  }

  void _loadSampleData() {
    // Load sample personal details
    const samplePersonalDetails = PersonalDetails(
      fullName: 'John Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1 (555) 123-4567',
      country: 'US',
      city: 'San Francisco',
      socialLinks: [
        SocialLink(
          platform: 'LinkedIn',
          url: 'https://linkedin.com/in/johndoe',
        ),
        SocialLink(platform: 'GitHub', url: 'https://github.com/johndoe'),
      ],
    );

    // Load sample professional summary
    const sampleProfessionalSummary = ProfessionalSummary(
      summary:
          'Experienced Senior Software Engineer with 6+ years developing scalable web applications and mobile solutions. Proven track record of leading cross-functional teams to deliver high-impact projects that increased user engagement by 40%. Passionate about clean code, mentoring junior developers, and implementing cutting-edge technologies to solve complex business problems.',
    );

    // Load sample work experience
    final sampleWorkExperience = [
      WorkExperience(
        position: 'Senior Software Engineer',
        organization: 'Tech Innovations Inc.',
        city: 'San Francisco, CA',
        keyTasks:
            '• Led a team of 5 engineers to develop a React-based customer portal serving 100K+ users\n• Implemented microservices architecture reducing API response time by 50%\n• Mentored 3 junior developers and conducted code reviews\n• Collaborated with product managers to define technical requirements',
        startDate: DateTime(2021, 3),
        isPresent: true,
      ),
      WorkExperience(
        position: 'Software Engineer',
        organization: 'Digital Solutions LLC',
        city: 'San Jose, CA',
        keyTasks:
            '• Developed full-stack applications using React, Node.js, and MongoDB\n• Built RESTful APIs serving 10K+ requests per day\n• Optimized database queries improving performance by 30%',
        startDate: DateTime(2019),
        endDate: DateTime(2021, 2),
      ),
    ];

    // Load sample education
    final sampleEducation = [
      Education(
        school: 'University of California, Berkeley',
        degree: 'Bachelor of Science in Computer Science',
        city: 'Berkeley, CA',
        startDate: DateTime(2015, 8),
        endDate: DateTime(2018, 5),
        description:
            'Graduated Magna Cum Laude. Relevant coursework: Data Structures, Algorithms, Software Engineering, Database Systems.',
      ),
    ];

    // Load sample skills
    final sampleSkills = [
      const Skill(
        name: 'JavaScript',
        category: SkillCategory.technical,
        proficiency: ProficiencyLevel.expert,
      ),
      const Skill(
        name: 'React',
        category: SkillCategory.technical,
        proficiency: ProficiencyLevel.expert,
      ),
      const Skill(
        name: 'Node.js',
        category: SkillCategory.technical,
        proficiency: ProficiencyLevel.advanced,
      ),
      const Skill(
        name: 'Python',
        category: SkillCategory.technical,
        proficiency: ProficiencyLevel.advanced,
      ),
      const Skill(
        name: 'Leadership',
        category: SkillCategory.soft,
        proficiency: ProficiencyLevel.advanced,
      ),
      const Skill(
        name: 'Communication',
        category: SkillCategory.soft,
        proficiency: ProficiencyLevel.advanced,
      ),
      const Skill(
        name: 'Problem Solving',
        category: SkillCategory.soft,
        proficiency: ProficiencyLevel.expert,
      ),
      const Skill(
        name: 'English',
        category: SkillCategory.languages,
        proficiency: ProficiencyLevel.expert,
      ),
      const Skill(
        name: 'Spanish',
        category: SkillCategory.languages,
        proficiency: ProficiencyLevel.intermediate,
      ),
    ];

    // Create updated resume data with sample information
    final updatedData = state.resumeData.copyWith(
      personalDetails: samplePersonalDetails,
      professionalSummary: sampleProfessionalSummary,
      workExperience: sampleWorkExperience,
      education: sampleEducation,
      skills: sampleSkills,
    );

    emit(state.copyWith(resumeData: updatedData));
    _updateResumeScore();
  }
}

part of 'ai_resume_builder_cubit.dart';

@freezed
sealed class AiResumeBuilderState with _$AiResumeBuilderState {
  const factory AiResumeBuilderState({
    @Default(ResumeData()) ResumeData resumeData,
    @Default(false) bool isLoading,
    @Default(<String>[]) List<String> errors,
    @Default('regular') String selectedTemplateId,
    @Default(false) bool isGenerating,
    ResumeItem? generationResult,
    String? paymentIntentId,
  }) = _AiResumeBuilderState;

  const AiResumeBuilderState._();

  bool get hasErrors => errors.isNotEmpty;
  bool get isPersonalDetailsComplete =>
      (resumeData.personalDetails?.fullName?.isNotEmpty ?? false) &&
      (resumeData.personalDetails?.email?.isNotEmpty ?? false);
  bool get isProfessionalSummaryComplete =>
      resumeData.professionalSummary?.summary?.isNotEmpty ?? false;
  bool get isWorkExperienceComplete => resumeData.workExperience.isNotEmpty;
  bool get isEducationComplete => resumeData.education.isNotEmpty;
  bool get isSkillsComplete => resumeData.skills.isNotEmpty;
  bool get isTemplateSelectionComplete => selectedTemplateId.isNotEmpty;
}

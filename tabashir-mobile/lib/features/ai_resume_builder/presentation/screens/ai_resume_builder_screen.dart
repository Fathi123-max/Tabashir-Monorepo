import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import '../cubit/ai_resume_builder_cubit.dart';
import '../widgets/ai_resume_builder_header.dart';
import 'steps/personal_details_step.dart';
import 'steps/professional_summary_step.dart';
import 'steps/work_experience_step.dart';
import 'steps/education_step.dart';
import 'steps/skills_step.dart';
import '../../data/models/resume_models.dart';

class AiResumeBuilderScreen extends StatelessWidget {
  const AiResumeBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => AiResumeBuilderCubit(),
    child: const AiResumeBuilderView(),
  );
}

class AiResumeBuilderView extends StatelessWidget {
  const AiResumeBuilderView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    appBar: AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'AI Resume Builder'.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),

      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
    ),
    body: BlocConsumer<AiResumeBuilderCubit, AiResumeBuilderState>(
      listener: (context, state) {
        if (state.hasErrors) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errors.first),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
      },
      builder: (context, state) => Column(
        children: [
          AiResumeBuilderHeader(
            currentStep: state.resumeData.currentStep,
            resumeScore: state.resumeData.resumeScore,
            onStepTap: (step) {
              context.read<AiResumeBuilderCubit>().goToStep(step);
            },
          ),
          Expanded(
            child: IndexedStack(
              index: state.resumeData.currentStep,
              children: const [
                PersonalDetailsStep(),
                ProfessionalSummaryStep(),
                WorkExperienceStep(),
                EducationStep(),
                SkillsStep(),
              ],
            ),
          ),
          _buildBottomActions(context, state),
        ],
      ),
    ),
  );

  Widget _buildBottomActions(
    BuildContext context,
    AiResumeBuilderState state,
  ) {
    final theme = Theme.of(context);
    final currentStep = state.resumeData.currentStep;
    final isLastStep = currentStep == BuilderStep.skills;

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (currentStep > 0) ...[
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      context.read<AiResumeBuilderCubit>().previousStep(),
                  child: Text('Back'.tr()),
                ),
              ),
              SizedBox(width: AppTheme.spacingMd.w),
            ],
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  final cubit = context.read<AiResumeBuilderCubit>();

                  // Only validate when generating CV (on last step)
                  // All steps are accessible at the same level
                  if (isLastStep) {
                    if (!cubit.validateCurrentStep()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Please complete all required fields'.tr(),
                          ),
                          backgroundColor: AppTheme.warningColor,
                        ),
                      );
                      return;
                    }
                    _showGenerateConfirmation(context);
                  } else {
                    cubit.nextStep();
                  }
                },
                child: Text(
                  isLastStep ? 'Generate CV'.tr() : 'Save & Continue'.tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showGenerateConfirmation(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Generate CV'.tr()),
        content: Text(
          'Your resume is ready! Would you like to generate and download your CV now?'
              .tr(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Review Again'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('CV generated successfully!'.tr()),
                  backgroundColor: AppTheme.successColor,
                ),
              );
              Navigator.pop(context);
            },
            child: Text('Generate'.tr()),
          ),
        ],
      ),
    );
  }
}

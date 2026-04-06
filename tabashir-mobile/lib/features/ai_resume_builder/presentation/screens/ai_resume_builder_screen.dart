import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import '../cubit/ai_resume_builder_cubit.dart';
import '../widgets/ai_resume_builder_header.dart';
import 'steps/personal_details_step.dart';
import 'steps/professional_summary_step.dart';
import 'steps/work_experience_step.dart';
import 'steps/education_step.dart';
import 'steps/skills_step.dart';
import 'steps/template_selection_step.dart';
import '../../../../core/network/models/ai_resume/resume_models.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/models/stripe/stripe_enums.dart';
import '../../../payments/presentation/cubit/payment_cubit.dart';
import '../../../payments/domain/repositories/payment_platform.dart';

class AiResumeBuilderScreen extends StatelessWidget {
  const AiResumeBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AiResumeBuilderCubit()),
      BlocProvider(create: (context) => getIt<PaymentCubit>()),
    ],
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
    body: MultiBlocListener(
      listeners: [
        BlocListener<AiResumeBuilderCubit, AiResumeBuilderState>(
          listener: (context, state) {
            if (state.hasErrors) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errors.first),
                  backgroundColor: AppTheme.errorColor,
                ),
              );
            }

            if (state.generationResult != null && !state.isGenerating) {
              context.pushReplacement(
                RouteNames.aiResumeBuilderSuccess,
                extra: state.generationResult,
              );
            }
          },
        ),
        BlocListener<PaymentCubit, PaymentState>(
          listener: (context, state) {
            if (state.status == PaymentStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: AppTheme.errorColor,
                ),
              );
            }
          },
        ),
        BlocListener<AiResumeBuilderCubit, AiResumeBuilderState>(
          listenWhen: (previous, current) =>
              previous.errors != current.errors &&
              current.errors.isNotEmpty &&
              !current.isLoading,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Generation failed: ${state.errors.first}. If you were charged, please contact support with your payment ID.'
                      .tr(),
                ),
                backgroundColor: Colors.pink,
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: 'Support'.tr(),
                  textColor: Colors.white,
                  onPressed: () {
                    // Navigate to support or show help
                  },
                ),
              ),
            );
          },
        ),
      ],
      child: BlocBuilder<AiResumeBuilderCubit, AiResumeBuilderState>(
        builder: (context, state) => Stack(
          children: [
            Column(
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
                      TemplateSelectionStep(),
                    ],
                  ),
                ),
                _buildBottomActions(context, state),
              ],
            ),
            if (state.isGenerating)
              ColoredBox(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Padding(
                      padding: EdgeInsets.all(AppTheme.spacingMd.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          SizedBox(height: AppTheme.spacingLg.h),
                          Text(
                            'Generating your professional CV...'.tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(height: AppTheme.spacingSm.h),
                          Text(
                            'This may take a few moments'.tr(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );

  Widget _buildBottomActions(
    BuildContext context,
    AiResumeBuilderState state,
  ) {
    final theme = Theme.of(context);
    final currentStep = state.resumeData.currentStep;
    final isLastStep = currentStep == BuilderStep.templateSelection;

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
                  onPressed: state.isGenerating
                      ? null
                      : () =>
                            context.read<AiResumeBuilderCubit>().previousStep(),
                  child: Text('Back'.tr()),
                ),
              ),
              SizedBox(width: AppTheme.spacingMd.w),
            ],
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: state.isGenerating
                    ? null
                    : () {
                        final cubit = context.read<AiResumeBuilderCubit>();

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

                        if (isLastStep) {
                          _showGenerateConfirmation(context, cubit);
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

  Future<void> _showGenerateConfirmation(
    BuildContext context,
    AiResumeBuilderCubit cubit,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Generate CV'.tr()),
        content: Text(
          'Your resume is ready! Would you like to generate and save your professional CV now?'
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

              // Trigger Payment Flow
              context.read<PaymentCubit>().onPaymentSuccess = (result) async {
                String? txnId;
                result.when(
                  success: (id) => txnId = id,
                  cancelled: () => txnId = null,
                  failed: (_) => txnId = null,
                );
                if (txnId != null) {
                  context.read<AiResumeBuilderCubit>().generateAndSave(
                    paymentIntentId: txnId,
                  );
                }
                context.read<PaymentCubit>().reset();
              };
              context.read<PaymentCubit>().processPayment(
                serviceId: 'ai-resume-optimization',
                amount: 40,
              );
            },
            child: Text('Pay & Generate'.tr()),
          ),
        ],
      ),
    );
  }
}

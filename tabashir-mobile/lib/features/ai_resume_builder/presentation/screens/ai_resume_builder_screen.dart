import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/models/stripe/stripe_enums.dart';
import '../../../../core/network/models/ai_resume/resume_models.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../payments/presentation/cubit/payment_cubit.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../cubit/ai_resume_builder_cubit.dart';
import '../widgets/ai_resume_builder_header.dart';
import 'steps/education_step.dart';
import 'steps/personal_details_step.dart';
import 'steps/professional_summary_step.dart';
import 'steps/skills_step.dart';
import 'steps/template_selection_step.dart';
import 'steps/work_experience_step.dart';
import 'steps/projects_step.dart';
import 'steps/leadership_step.dart';
import '../../../../shared/widgets/ai_consent_bottom_sheet.dart';

class AiResumeBuilderScreen extends StatelessWidget {
  const AiResumeBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AiResumeBuilderCubit()),
      BlocProvider(create: (context) => getIt<PaymentCubit>()),
      BlocProvider.value(value: getIt<ProfileCubit>()),
    ],
    child: const AiResumeBuilderView(),
  );
}

class AiResumeBuilderView extends StatefulWidget {
  const AiResumeBuilderView({super.key});

  @override
  State<AiResumeBuilderView> createState() => _AiResumeBuilderViewState();
}

class _AiResumeBuilderViewState extends State<AiResumeBuilderView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final consented = await AiConsentBottomSheet.ensureConsent(context);
      if (!consented && mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.adaptive.arrow_back),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'AI Resume Builder'.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.bug_report_outlined),
          tooltip: 'Test Mock Data'.tr(),
          onSelected: (value) {
            final cubit = context.read<AiResumeBuilderCubit>();
            if (value == 'english') {
              cubit.loadEnglishSampleData();
            } else if (value == 'arabic') {
              cubit.loadArabicSampleData();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'english',
              child: Text('Load English Mock Data'.tr()),
            ),
            PopupMenuItem(
              value: 'arabic',
              child: Text('Load Arabic Mock Data'.tr()),
            ),
          ],
        ),
      ],
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
                      ResumeProjectsStep(),
                      LeadershipStep(),
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
    final profileState = context.read<ProfileCubit>().state;
    final plan = profileState.profile?.subscriptionPlan?.toUpperCase() ?? '';
    final isSubscribed =
        plan == 'PRO' ||
        plan == 'AI APPLY' ||
        plan == 'AI_APPLY' ||
        plan == 'PROFESSIONAL';

    if (!context.mounted) return;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Generate CV'.tr()),
        content: Text(
          isSubscribed
              ? 'Your resume is ready! Since you have an active subscription, you can generate your professional CV for free.'
                    .tr()
              : 'Your resume is ready! Would you like to generate and save your professional CV now?'
                    .tr(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Review Again'.tr()),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(dialogContext);

              if (!context.mounted) return;

              // 1. Select Format
              final format = await showDialog<String>(
                context: context,
                builder: (formatContext) => AlertDialog(
                  title: Text('Select Output Format'.tr()),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.picture_as_pdf,
                          color: Colors.red,
                        ),
                        title: const Text('PDF Document'),
                        onTap: () => Navigator.pop(formatContext, 'pdf'),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.description,
                          color: Colors.blue,
                        ),
                        title: const Text('Word Document (DOCX)'),
                        onTap: () => Navigator.pop(formatContext, 'docx'),
                      ),
                    ],
                  ),
                ),
              );

              if (format == null || !context.mounted) return;

              // TEMPORARY: Skip payment flow for testing
              cubit.generateAndSave(
                outputFormat: format,
              );
              return;

              /* // Payment Flow (Disabled for testing)
              if (isSubscribed) {
                // Free generation for subscribers
                cubit.generateAndSave(
                  outputFormat: format,
                );
                return;
              }

              // 2. Trigger Payment Flow for non-subscribers
              final paymentCubit = context.read<PaymentCubit>();

              paymentCubit.onPaymentSuccess = (result) async {
                String? txnId;
                result.when(
                  success: (id) => txnId = id,
                  cancelled: () => txnId = null,
                  failed: (_) => txnId = null,
                );

                if (txnId != null && context.mounted) {
                  cubit.generateAndSave(
                    paymentIntentId: txnId,
                    outputFormat: format,
                  );
                }
                paymentCubit.reset();
              };

              try {
                await paymentCubit.processPayment(
                  serviceId: 'ai_resume_optimization',
                  amount: 40,
                );
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${'payment_init_failed'.tr()}: $e'),
                      backgroundColor: AppTheme.errorColor,
                    ),
                  );
                }
              }
              */
            },
            child: Text(isSubscribed ? 'Generate'.tr() : 'Pay & Generate'.tr()),
          ),
        ],
      ),
    );
  }
}

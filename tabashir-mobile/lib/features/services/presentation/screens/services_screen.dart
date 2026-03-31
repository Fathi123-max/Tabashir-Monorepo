import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_request.dart';
import 'package:tabashir/core/network/models/send_linkedin_email_request.dart';
import 'package:tabashir/core/network/services/job/tabashir_api_service.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/models/stripe/stripe_enums.dart';
import 'package:tabashir/features/payments/presentation/cubit/payment_cubit.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import '../cubit/services_cubit.dart';
import '../widgets/info_banner.dart';
import '../widgets/service_card.dart';
import '../widgets/trust_indicators.dart';

/// Services screen that displays AI career services including:
/// - AI Resume Optimization
/// - AI LinkedIn Enhancement
/// - AI Job Apply Service
/// - Interview Prep AI
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  void _onLinkedInEnhancerPressed(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    final userId = profileCubit.currentUserId;
    final profile = profileCubit.state.profile;

    if (userId == null || profile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please login to continue'.tr())),
      );
      return;
    }

    // Trigger payment intent creation for LinkedIn Enhancement (19 AED)
    context.read<PaymentCubit>().createPaymentIntent(
          request: PaymentIntentRequest(
            userId: userId,
            serviceId: 'ai-linkedin-enhancement',
            amount: 19.0, // 19 AED
            currency: 'aed',
          ),
        );
  }

  Future<void> _processLinkedInEnhancement(
    BuildContext context,
    String paymentIntentId,
  ) async {
    final profileCubit = context.read<ProfileCubit>();
    final profile = profileCubit.state.profile;

    if (profile == null) return;

    try {
      final apiService = getIt<TabashirApiService>();
      await apiService.sendLinkedInEmail(
        SendLinkedInEmailRequest(
          recipientEmail: profile.email,
          recipientName: profile.name,
          paymentIntentId: paymentIntentId,
        ),
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('LinkedIn Enhancement request sent successfully!'.tr()),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to process enhancement. Please contact support.'.tr()),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ServicesCubit()..initialize()),
        BlocProvider(create: (context) => getIt<PaymentCubit>()),
      ],
      child: MultiBlocListener(
        listeners: [
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

              if (state.paymentSheetInitialized &&
                  state.status == PaymentStatus.success &&
                  !state.paymentSuccessful) {
                // Payment sheet is ready, open it
                context.read<PaymentCubit>().processPaymentSheet();
              }

              if (state.paymentSuccessful) {
                final paymentId = state.paymentIntent?.data?.paymentIntentId;
                if (paymentId != null) {
                  _processLinkedInEnhancement(context, paymentId);
                  // Reset payment state for next time
                  context.read<PaymentCubit>().reset();
                }
              }
            },
          ),
        ],
        child: BlocBuilder<ServicesCubit, ServicesState>(
          builder: (context, state) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  // Main scrollable content
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(
                        bottom: kBottomNavigationBarHeight + AppTheme.spacingLg.h,
                      ),
                      children: [
                        // Header
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            AppTheme.spacingMd.w,
                            AppTheme.spacingLg.h,
                            AppTheme.spacingMd.w,
                            AppTheme.spacingXs.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Career Services'.tr(),
                                style: theme.textTheme.displayMedium?.copyWith(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: AppTheme.spacingXs.h),
                              Text(
                                'Boost your job search with smart tools.'.tr(),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Info Banner
                        Padding(
                          padding: EdgeInsets.all(AppTheme.spacingMd.w),
                          child: const InfoBanner(),
                        ),

                        // Service Cards
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingMd.w,
                          ),
                          child: Column(
                            children: [
                              ServiceCard(
                                icon: Icons.description_outlined,
                                title: 'AI Resume Optimization'.tr(),
                                description:
                                    'Get your resume scored and optimized by AI to '
                                            .tr() +
                                        'pass ATS and impress recruiters.'.tr(),
                                price: 'Free trial • AED 29'.tr(),
                                buttonText: 'Get Started'.tr(),
                                isEnabled: true,
                                onPressed: () {
                                  context.pushNamed('ai-resume-screen');
                                },
                              ),
                              SizedBox(height: AppTheme.spacingMd.h),

                              ServiceCard(
                                icon: Icons.link,
                                title: 'AI LinkedIn Enhancement'.tr(),
                                description:
                                    'Optimize your LinkedIn profile to attract more '
                                            .tr() +
                                        'recruiters and opportunities.'.tr(),
                                price: 'AED 19'.tr(),
                                buttonText: 'Enhance Now'.tr(),
                                isEnabled: true,
                                onPressed: () {
                                  _onLinkedInEnhancerPressed(context);
                                },
                              ),
                              SizedBox(height: AppTheme.spacingMd.h),

                              ServiceCard(
                                icon: Icons.flash_on,
                                title: 'AI Job Apply Service'.tr(),
                                description:
                                    'Let our AI find and apply to the best jobs for '
                                            .tr() +
                                        'you automatically.'.tr(),
                                price: 'AED 49'.tr(),
                                buttonText: 'Auto Apply'.tr(),
                                isEnabled: true,
                                onPressed: () {
                                  context.pushNamed('subscriptions-screen');
                                },
                              ),
                              SizedBox(height: AppTheme.spacingMd.h),

                              ServiceCard(
                                icon: Icons.mic,
                                title: 'Interview Prep AI'.tr(),
                                description:
                                    'Practice with an AI interviewer and get instant '
                                            .tr() +
                                        'feedback to ace your next interview.'.tr(),
                                price: 'Coming Soon'.tr(),
                                buttonText: 'Notify Me'.tr(),
                                isEnabled: true,
                                onPressed: () {
                                  context.pushNamed(
                                    'interview-training-screen',
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        // Trust Indicators
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingMd.w,
                            vertical: AppTheme.spacingLg.h,
                          ),
                          child: const TrustIndicators(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

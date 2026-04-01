import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_request.dart';
import 'package:tabashir/features/payments/presentation/cubit/payment_cubit.dart';

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

  Future<void> _onLinkedInEnhancerPressed(BuildContext context) async {
    // WhatsApp number (format: country code + number without + or spaces)
    const whatsappNumber = '971529983824';
    final whatsappUrl = Uri.parse(
      'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent('Hello, I am interested in LinkedIn Enhancement service')}',
    );

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(
        whatsappUrl,
        mode: LaunchMode.externalApplication,
      );
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open WhatsApp'.tr()),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  void _onJobApplyServicePressed(
    BuildContext context,
    String serviceId,
    double amount,
    String serviceTitle,
  ) async {
    final paymentCubit = context.read<PaymentCubit>();

    // Create payment intent
    final request = PaymentIntentRequest(
      amount: amount,
      currency: 'AED',
      serviceId: serviceId,
      serviceTitle: serviceTitle,
    );

    await paymentCubit.createPaymentIntent(request: request);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ServicesCubit()..initialize(),
        ),
        BlocProvider.value(
          value: getIt<PaymentCubit>(),
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
                      bottom: kBottomNavigationBarHeight + AppTheme.spacingXl.h,
                    ),
                    children: [
                      // Header
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          AppTheme.spacingLg.w,
                          AppTheme.spacingXl.h,
                          AppTheme.spacingLg.w,
                          AppTheme.spacingMd.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AI Career Services'.tr(),
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: AppTheme.spacingXs.h),
                            Text(
                              'Boost your job search with smart tools.'.tr(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Info Banner
                      // Hidden: Users who optimize their resume get 3x more interviews
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: AppTheme.spacingLg.w,
                      //   ),
                      //   child: const InfoBanner(),
                      // ),

                      // Service Cards
                      Padding(
                        padding: EdgeInsets.all(AppTheme.spacingLg.w),
                        child: Column(
                          children: [
                            ServiceCard(
                              icon: Icons.flash_on_rounded,
                              title: 'AI Job Apply Service - Basic'.tr(),
                              description:
                                  'Let our AI find and apply to the best jobs for '
                                      .tr() +
                                  'you automatically.'.tr(),
                              price: 'AED 200'.tr(),
                              buttonText: 'Auto Apply'.tr(),
                              isEnabled: true,
                              onPressed: () {
                                _onJobApplyServicePressed(
                                  context,
                                  'ai-job-apply',
                                  200,
                                  'AI Job Apply Service - Basic',
                                );
                              },
                            ),
                            SizedBox(height: AppTheme.spacingMd.h),

                            ServiceCard(
                              icon: Icons.workspace_premium_rounded,
                              title: 'AI Job Apply Service - Premium'.tr(),
                              description:
                                  'Premium plan with priority applications and '
                                      .tr() +
                                  'advanced AI matching.'.tr(),
                              price: 'AED 200'.tr(),
                              buttonText: 'Auto Apply'.tr(),
                              isEnabled: true,
                              onPressed: () {
                                _onJobApplyServicePressed(
                                  context,
                                  'ai-job-apply',
                                  200,
                                  'AI Job Apply Service - Premium',
                                );
                              },
                            ),
                            SizedBox(height: AppTheme.spacingMd.h),

                            ServiceCard(
                              icon: Icons.description_rounded,
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
                              icon: Icons.link_rounded,
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
                          ],
                        ),
                      ),

                      // Trust Indicators
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingLg.w,
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
    );
  }
}

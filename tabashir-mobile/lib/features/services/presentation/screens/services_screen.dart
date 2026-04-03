import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_request.dart';
import 'package:tabashir/core/network/models/payment/payment_intent_response.dart';
import 'package:tabashir/core/models/stripe/stripe_enums.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/payments/presentation/cubit/payment_cubit.dart';
import 'package:tabashir/features/payments/presentation/screens/payment_success_screen.dart';
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
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String? _pendingServiceTitle;
  double? _pendingAmount;

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

  Future<void> _onJobApplyServicePressed(
    BuildContext context,
    String serviceId,
    double amount,
    String serviceTitle,
  ) async {
    final paymentCubit = context.read<PaymentCubit>();

    // Store service info for success screen
    setState(() {
      _pendingServiceTitle = serviceTitle;
      _pendingAmount = amount;
    });

    // Set callback for successful payment (fires even if widget is disposed)
    paymentCubit.onPaymentSuccess = (paymentIntent) {
      if (!mounted) return;
      _navigateToSuccessScreen(paymentIntent);
    };

    // Create payment intent
    final request = PaymentIntentRequest(
      amount: amount,
      currency: 'AED',
      serviceId: serviceId,
      serviceTitle: serviceTitle,
    );

    await paymentCubit.createPaymentIntent(request: request);
    // Note: Navigation to success screen is handled by onPaymentSuccess callback
    // Do NOT add navigation logic here
  }

  void _navigateToSuccessScreen(PaymentIntentResponse? paymentIntent) {
    // Wait for Stripe payment sheet to fully dismiss before navigating
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;

      final transactionId = paymentIntent?.data?.paymentIntentId;

      print(
        '[ServicesScreen] Navigating to PaymentSuccessScreen: '
        'service=$_pendingServiceTitle, amount=$_pendingAmount',
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => PaymentSuccessScreen(
            serviceTitle: _pendingServiceTitle,
            amount: _pendingAmount,
            transactionId: transactionId,
            onOkPressed: () async {
              // Refresh profile and home data before navigating home
              try {
                print('[ServicesScreen] onOkPressed: refreshing profile...');
                await getIt<ProfileCubit>().loadProfileData(force: true);
                final homeCubit = getIt<HomeCubit>();
                final email =
                    getIt<ProfileCubit>().state.profile?.email ?? '';
                print('[ServicesScreen] onOkPressed: email=$email');
                if (email.isNotEmpty) {
                  print('[ServicesScreen] onOkPressed: refreshing home...');
                  await homeCubit.loadAiEnhancedHomeData(email: email);
                }
                print('[ServicesScreen] onOkPressed: refresh complete');
              } catch (e) {
                print(
                  '[ServicesScreen] Error refreshing data on OK: $e',
                );
              }
            },
          ),
        ),
        (route) => route.isFirst, // Keep only the first route (home)
      );

      // Clear pending info
      setState(() {
        _pendingServiceTitle = null;
        _pendingAmount = null;
      });
    });
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
      child: BlocListener<PaymentCubit, PaymentState>(
        // Navigation is handled by onPaymentSuccess callback on the cubit.
        // This listener is kept as a fallback but should not be needed.
        listener: (context, state) {},
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
                        // Hero Header with gradient background
                        Container(
                          margin: EdgeInsets.fromLTRB(
                            AppTheme.spacingMd.w,
                            AppTheme.spacingLg.h,
                            AppTheme.spacingMd.w,
                            AppTheme.spacingMd.h,
                          ),
                          padding: EdgeInsets.all(AppTheme.spacingLg.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppTheme.primaryColor.withOpacity(0.1),
                                AppTheme.primaryColor.withOpacity(0.05),
                                theme.scaffoldBackgroundColor,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusLarge.r,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(AppTheme.spacingSm.w),
                                    decoration: BoxDecoration(
                                      gradient: AppTheme.primaryGradient,
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radiusMedium.r,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withOpacity(0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.auto_awesome_rounded,
                                      size: 24.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: AppTheme.spacingMd.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'AI Services',
                                          style: theme.textTheme.displayMedium
                                              ?.copyWith(
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                        ),
                                        SizedBox(height: AppTheme.spacingXs.h),
                                        Text(
                                          'Boost your job search with smart tools.',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: theme
                                                    .colorScheme
                                                    .onSurfaceVariant,
                                                fontSize: 14.sp,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Service Cards
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingMd.w,
                          ),
                          child: Column(
                            children: [
                              // Featured Badge
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: AppTheme.spacingMd.h,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppTheme.spacingMd.w,
                                  vertical: AppTheme.spacingSm.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusFull.r,
                                  ),
                                  border: Border.all(
                                    color: AppTheme.primaryColor.withOpacity(0.2),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star_rounded,
                                      size: 16.sp,
                                      color: AppTheme.primaryColor,
                                    ),
                                    SizedBox(width: AppTheme.spacingXs.w),
                                    Text(
                                      'Most Popular',
                                      style: theme.textTheme.labelLarge?.copyWith(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              ServiceCard(
                                icon: Icons.workspace_premium_rounded,
                                title: 'AI Job Apply Service - Premium',
                                description:
                                    'Premium plan with priority applications and '
                                        .tr() +
                                    'advanced AI matching.'.tr(),
                                price: 'AED 200',
                                buttonText: 'Auto Apply'.tr(),
                                isEnabled: true,
                                isFeatured: true,
                                onPressed: () {
                                  _onJobApplyServicePressed(
                                    context,
                                    'ai-job-apply-premium',
                                    200,
                                    'AI Job Apply Service - Premium',
                                  );
                                },
                              ),
                              SizedBox(height: AppTheme.spacingMd.h),

                              ServiceCard(
                                icon: Icons.flash_on_rounded,
                                title: 'AI Job Apply Service - Basic',
                                description:
                                    'Let our AI find and apply to the best jobs for '
                                        .tr() +
                                    'you automatically.'.tr(),
                                price: 'AED 100',
                                buttonText: 'Auto Apply'.tr(),
                                isEnabled: true,
                                onPressed: () {
                                  _onJobApplyServicePressed(
                                    context,
                                    'ai-job-apply-basic',
                                    100,
                                    'AI Job Apply Service - Basic',
                                  );
                                },
                              ),
                              SizedBox(height: AppTheme.spacingMd.h),

                              ServiceCard(
                                icon: Icons.description_rounded,
                                title: 'AI Resume Optimization',
                                description:
                                    'Get your resume scored and optimized by AI to '
                                        .tr() +
                                    'pass ATS and impress recruiters.'.tr(),
                                price: 'Free trial • AED 29',
                                buttonText: 'Get Started'.tr(),
                                isEnabled: true,
                                badgeText: 'Free Trial',
                                onPressed: () {
                                  context.pushNamed('ai-resume-screen');
                                },
                              ),
                              SizedBox(height: AppTheme.spacingMd.h),

                              ServiceCard(
                                icon: Icons.link_rounded,
                                title: 'AI LinkedIn Enhancement',
                                description:
                                    'Optimize your LinkedIn profile to attract more '
                                        .tr() +
                                    'recruiters and opportunities.'.tr(),
                                price: 'AED 19',
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
                          padding: EdgeInsets.all(AppTheme.spacingMd.w),
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

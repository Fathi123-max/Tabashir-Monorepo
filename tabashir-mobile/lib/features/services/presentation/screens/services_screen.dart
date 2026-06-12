import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_logger.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import '../../../payments/domain/repositories/payment_platform.dart';
import '../../../payments/presentation/cubit/payment_cubit.dart';
import '../../../payments/presentation/screens/payment_success_screen.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../cubit/services_cubit.dart';
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

  Future<void> _redirectToWhatsApp({
    required BuildContext context,
    required String serviceTitle,
    required double amount,
  }) async {
    final profileCubit = getIt<ProfileCubit>();
    final profile = profileCubit.state.profile;
    final userName = profile?.name ?? 'Candidate';
    final userEmail = profile?.email ?? 'Not specified';

    // WhatsApp number (format: country code + number without + or spaces)
    const whatsappNumber = '971529983824';

    // Construct a professional message with user information
    final message =
        'Hello Tabashir Support, my name is $userName ($userEmail). '
        'I would like to purchase the "${serviceTitle.tr()}" service for $amount AED. '
        'Please guide me on how to complete the payment.';

    final whatsappUrl = Uri.parse(
      'https://wa.me/$whatsappNumber?text=${Uri.encodeComponent(message)}',
    );

    AppLogger.debug(
      '[ServicesScreen] Redirecting to WhatsApp for iOS: $message',
      tag: 'Services',
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

  Future<void> _onLinkedInEnhancerPressed(BuildContext context) async {
    // For LinkedIn enhancement, we use the same WhatsApp redirection pattern
    await _redirectToWhatsApp(
      context: context,
      serviceTitle: 'ai_linkedin_enhancement_title',
      amount: 19,
    );
  }

  Future<void> _onJobApplyServicePressed(
    BuildContext context,
    String serviceId,
    double amount,
    String serviceTitle,
  ) async {
    // On iOS, we redirect to WhatsApp as per business requirements
    if (Platform.isIOS) {
      await _redirectToWhatsApp(
        context: context,
        serviceTitle: serviceTitle,
        amount: amount,
      );
      return;
    }

    final paymentCubit = context.read<PaymentCubit>();

    // Store service info for success screen
    setState(() {
      _pendingServiceTitle = serviceTitle;
      _pendingAmount = amount;
    });

    // Set callback for successful payment (fires even if widget is disposed)
    paymentCubit.onPaymentSuccess = (result) async {
      String? txnId;
      result.when(
        success: (id) => txnId = id,
        cancelled: () => txnId = null,
        failed: (_) => txnId = null,
      );
      if (mounted) {
        _navigateToSuccessScreen(txnId);
      }
    };

    // Process payment
    await paymentCubit.processPayment(
      serviceId: serviceId,
      amount: amount,
    );
    // Note: Navigation to success screen is handled by onPaymentSuccess callback
    // Do NOT add navigation logic here
  }

  void _navigateToSuccessScreen(String? transactionId) {
    // Wait for payment sheet animation to dismiss before navigating
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        AppLogger.debug(
          '[ServicesScreen] Navigating to PaymentSuccessScreen: '
          'service=$_pendingServiceTitle, amount=$_pendingAmount',
          tag: 'Services',
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
                  AppLogger.debug(
                    '[ServicesScreen] onOkPressed: refreshing profile...',
                    tag: 'Services',
                  );
                  await getIt<ProfileCubit>().loadProfileData(force: true);
                  final homeCubit = getIt<HomeCubit>();
                  final email =
                      getIt<ProfileCubit>().state.profile?.email ?? '';
                  AppLogger.debug(
                    '[ServicesScreen] onOkPressed: email=$email',
                    tag: 'Services',
                  );
                  if (email.isNotEmpty) {
                    AppLogger.debug(
                      '[ServicesScreen] onOkPressed: refreshing home...',
                      tag: 'Services',
                    );
                    await homeCubit.loadAiEnhancedHomeData(email: email);
                  }
                  AppLogger.debug(
                    '[ServicesScreen] onOkPressed: refresh complete',
                    tag: 'Services',
                  );
                } catch (e) {
                  AppLogger.error(
                    '[ServicesScreen] Error refreshing data on OK: $e',
                    tag: 'Services',
                    error: e,
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
      }
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
                        bottom:
                            kBottomNavigationBarHeight + AppTheme.spacingXl.h,
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
                                    padding: EdgeInsets.all(
                                      AppTheme.spacingSm.w,
                                    ),
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
                                          'AI Services'.tr(),
                                          style: theme.textTheme.displayMedium
                                              ?.copyWith(
                                                fontSize: 28.sp,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                        ),
                                        SizedBox(height: AppTheme.spacingXs.h),
                                        Text(
                                          'Boost your job search with smart tools.'
                                              .tr(),
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
                                    color: AppTheme.primaryColor.withOpacity(
                                      0.2,
                                    ),
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
                                      'most_popular'.tr(),
                                      style: theme.textTheme.labelLarge
                                          ?.copyWith(
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
                                title: 'ai_job_apply_premium_title'.tr(),
                                description:
                                    '${'ai_job_apply_premium_desc'.tr()} ${'aiJobApplyNote'.tr()}',
                                price: 'aed_200'.tr(),
                                buttonText: 'Contact Support'.tr(),
                                isEnabled: true,
                                isFeatured: true,
                                onPressed: () {
                                  _onJobApplyServicePressed(
                                    context,
                                    'ai_job_apply_premium',
                                    200,
                                    'ai_job_apply_premium_title',
                                  );
                                },
                              ),
                              SizedBox(height: AppTheme.spacingMd.h),

                              ServiceCard(
                                icon: Icons.flash_on_rounded,
                                title: 'ai_job_apply_basic_title'.tr(),
                                description:
                                    '${'ai_job_apply_basic_desc'.tr()} ${'aiJobApplyNote'.tr()}',
                                price: 'aed_100'.tr(),
                                buttonText: 'Contact Support'.tr(),
                                isEnabled: true,
                                onPressed: () {
                                  _onJobApplyServicePressed(
                                    context,
                                    'ai_job_apply_basic',
                                    100,
                                    'ai_job_apply_basic_title',
                                  );
                                },
                              ),
                              SizedBox(height: AppTheme.spacingMd.h),

                              ServiceCard(
                                icon: Icons.link_rounded,
                                title: 'ai_linkedin_enhancement_title'.tr(),
                                description:
                                    'ai_linkedin_enhancement_desc_1'.tr() +
                                    'ai_linkedin_enhancement_desc_2'.tr(),
                                price: 'aed_19'.tr(),
                                buttonText: 'enhance_now'.tr(),
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

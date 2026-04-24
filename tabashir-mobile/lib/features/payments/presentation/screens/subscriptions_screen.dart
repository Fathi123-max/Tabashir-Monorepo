import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/apple_iap_service.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/utils/app_logger.dart';
import 'package:tabashir/features/payments/presentation/cubit/payment_cubit.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';

/// Subscription screen showing available plans, current subscription status,
/// and restore purchases button (required by Apple Guideline 3.1.1).
class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  late final PaymentCubit _paymentCubit;
  late final ProfileCubit _profileCubit;
  bool _isRestoring = false;
  String? _restoreMessage;
  bool _restoreSuccess = false;

  @override
  void initState() {
    super.initState();
    _paymentCubit = getIt<PaymentCubit>();
    _profileCubit = getIt<ProfileCubit>();
  }

  Future<void> _restorePurchases() async {
    setState(() {
      _isRestoring = true;
      _restoreMessage = null;
      _restoreSuccess = false;
    });

    try {
      if (Platform.isIOS) {
        // Use Apple IAP restore
        final appleIAP = getIt<AppleIAPService>();
        await appleIAP.restorePurchases();
      } else {
        // Android restore via InAppPurchase
        final iap = InAppPurchase.instance;
        await iap.restorePurchases();
      }

      // Refresh profile to get updated subscription status
      await _profileCubit.loadProfileData(force: true);

      if (mounted) {
        setState(() {
          _restoreSuccess = true;
          _restoreMessage = 'Purchases restored successfully'.tr();
        });
      }
    } on Exception catch (e) {
      AppLogger.error(
        '[SubscriptionsScreen] Failed to restore purchases: $e',
        tag: 'Subscriptions',
      );
      if (mounted) {
        setState(() {
          _restoreSuccess = false;
          _restoreMessage = 'Failed to restore purchases: $e'.tr();
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isRestoring = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileState = _profileCubit.state;
    final subscriptionPlan = profileState.profile?.subscriptionPlan;
    final subscriptionStatus = profileState.profile?.subscriptionStatus;

    return Scaffold(
      appBar: AppBar(
        title: Text('Subscriptions'.tr()),
        backgroundColor: theme.scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current Subscription Status Card
            _buildCurrentStatusCard(
              theme,
              plan: subscriptionPlan,
              status: subscriptionStatus,
            ),
            SizedBox(height: AppTheme.spacingLg.h),

            // Available Plans Section
            Text(
              'Available Plans'.tr(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Free Plan
            _buildPlanCard(
              theme,
              planName: 'Free',
              price: 'AED 0/month',
              features: [
                'Browse jobs',
                'Basic profile',
                '1 resume',
              ],
              isCurrentPlan:
                  subscriptionPlan == null || subscriptionPlan.isEmpty,
              onTap: () {},
            ),
            SizedBox(height: AppTheme.spacingSm.h),

            // Pro Plan
            _buildPlanCard(
              theme,
              planName: 'Pro',
              price: 'AED 49/month',
              features: [
                'Unlimited job applications',
                'AI resume builder',
                'Priority matching',
                'Application tracking',
              ],
              isCurrentPlan: subscriptionPlan?.toUpperCase() == 'PRO',
              onTap: _handleUpgradeToPro,
            ),
            SizedBox(height: AppTheme.spacingLg.h),

            // Restore Purchases (Apple Requirement)
            _buildRestorePurchasesButton(theme),

            if (_restoreMessage != null) ...[
              SizedBox(height: AppTheme.spacingSm.h),
              Container(
                padding: EdgeInsets.all(AppTheme.spacingSm.w),
                decoration: BoxDecoration(
                  color: _restoreSuccess
                      ? AppTheme.successColor.withValues(alpha: 0.1)
                      : AppTheme.errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                  border: Border.all(
                    color: _restoreSuccess
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                  ),
                ),
                child: Text(
                  _restoreMessage!,
                  style: TextStyle(
                    color: _restoreSuccess
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                    fontSize: 12.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStatusCard(
    ThemeData theme, {
    String? plan,
    String? status,
  }) {
    final isPro = plan?.toUpperCase() == 'PRO';

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        gradient: isPro ? AppTheme.primaryGradient : null,
        color: isPro ? null : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Plan'.tr(),
            style: TextStyle(
              fontSize: 14.sp,
              color: isPro ? Colors.white : theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: AppTheme.spacingXs.h),
          Text(
            plan?.toUpperCase() ?? 'Free',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: isPro ? Colors.white : theme.colorScheme.onSurface,
            ),
          ),
          if (status != null) ...[
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              'Status: $status'.tr(),
              style: TextStyle(
                fontSize: 12.sp,
                color: isPro
                    ? Colors.white70
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    ThemeData theme, {
    required String planName,
    required String price,
    required List<String> features,
    required VoidCallback onTap,
    bool isCurrentPlan = false,
  }) => GestureDetector(
      onTap: isCurrentPlan ? null : onTap,
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: isCurrentPlan
              ? AppTheme.primaryColor.withValues(alpha: 0.1)
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          border: Border.all(
            color: isCurrentPlan
                ? AppTheme.primaryColor
                : theme.colorScheme.outline,
            width: isCurrentPlan ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  planName,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isCurrentPlan)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingSm.w,
                      vertical: AppTheme.spacingXs.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(
                        AppTheme.radiusSmall.r,
                      ),
                    ),
                    child: Text(
                      'Current Plan'.tr(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              price,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            ...features.map(
              (feature) => Padding(
                padding: EdgeInsets.only(bottom: AppTheme.spacingXs.h),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 16.sp,
                      color: AppTheme.successColor,
                    ),
                    SizedBox(width: AppTheme.spacingXs.w),
                    Text(
                      feature,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  Widget _buildRestorePurchasesButton(ThemeData theme) => OutlinedButton.icon(
      onPressed: _isRestoring ? null : _restorePurchases,
      icon: _isRestoring
          ? SizedBox(
              width: 16.w,
              height: 16.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: theme.colorScheme.primary,
              ),
            )
          : const Icon(Icons.restore),
      label: Text('Restore Purchases'.tr()),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: AppTheme.spacingMd.h),
      ),
    );

  void _handleUpgradeToPro() {
    // Trigger payment through PaymentCubit
    // The actual service ID and amount should come from backend config
    _paymentCubit.onPaymentSuccess = (_) async {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully upgraded to Pro!'.tr()),
            backgroundColor: AppTheme.successColor,
          ),
        );
        await _profileCubit.loadProfileData(force: true);
      }
    };

    _paymentCubit.processPayment(
      serviceId: 'pro_subscription',
      amount: 49,
    );
  }
}

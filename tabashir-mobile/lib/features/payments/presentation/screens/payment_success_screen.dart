import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Success screen displayed after successful payment
class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({
    super.key,
    this.serviceTitle,
    this.amount,
    this.transactionId,
    this.onOkPressed,
  });

  final String? serviceTitle;
  final double? amount;
  final String? transactionId;
  final Future<void> Function()? onOkPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppTheme.spacingXl.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),

              // Success Animation
              _buildSuccessAnimation(),

              SizedBox(height: AppTheme.spacingXl.h),

              // Success Title
              Text(
                'Payment Successful!',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.successColor,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppTheme.spacingMd.h),

              // Service Title
              if (serviceTitle != null)
                Text(
                  serviceTitle!,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),

              SizedBox(height: AppTheme.spacingSm.h),

              // Amount Paid
              if (amount != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd.w,
                    vertical: AppTheme.spacingSm.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    'AED ${amount!.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),

              SizedBox(height: AppTheme.spacingLg.h),

              // What's Next Section
              _buildWhatsNextSection(theme),

              SizedBox(height: AppTheme.spacingXl.h),

              // Transaction ID (if available)
              if (transactionId != null)
                Container(
                  padding: EdgeInsets.all(AppTheme.spacingMd.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Transaction ID',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingXs.h),
                      Text(
                        transactionId!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                          color: theme.colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

              SizedBox(height: AppTheme.spacingMd.h),

              // OK Button - Refreshes data and navigates to home
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    AppLogger.debug('[PaymentSuccessScreen] OK button pressed', tag: 'Payments');
                    if (onOkPressed != null) {
                      await onOkPressed!();
                    }
                    AppLogger.debug('[PaymentSuccessScreen] Popping back to home', tag: 'Payments');
                    if (context.mounted) {
                      // Since we pushed with Navigator, we pop with Navigator
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'OK',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppTheme.spacingLg.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessAnimation() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppTheme.successGradient,
        boxShadow: [
          BoxShadow(
            color: AppTheme.successColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.check_circle_rounded,
        size: 64.sp,
        color: Colors.white,
      ),
    );
  }

  Widget _buildWhatsNextSection(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                color: AppTheme.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: AppTheme.spacingSm.w),
              Text(
                'What\'s Next?',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          _buildFeatureItem(
            icon: Icons.auto_awesome_rounded,
            title: 'AI Job Apply Activated',
            description: 'Your CV has been formatted and optimized',
            theme: theme,
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          _buildFeatureItem(
            icon: Icons.numbers_rounded,
            title: 'Job Credits Added',
            description: '100-200 AI job applications ready to use',
            theme: theme,
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          _buildFeatureItem(
            icon: Icons.rocket_launch_rounded,
            title: 'Start Applying',
            description: 'Head to home to begin auto-applying',
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required ThemeData theme,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(AppTheme.spacingXs.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: AppTheme.primaryColor,
          ),
        ),
        SizedBox(width: AppTheme.spacingMd.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 13.sp,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

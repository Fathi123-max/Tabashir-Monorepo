import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    required this.name,
    required this.jobTitle,
    required this.location,
    required this.profileStrength,
    this.onEditPressed,
    this.userType,
    this.profileImage,
    super.key,
  });
  final String name;
  final String jobTitle;
  final String location;
  final int profileStrength;
  final VoidCallback? onEditPressed;
  final String? userType;
  final String? profileImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Image
              Stack(
                children: [
                  Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primaryContainer,
                      border: Border.all(
                        color: theme.colorScheme.primary.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: profileImage != null && profileImage!.isNotEmpty
                          ? Image.network(
                              profileImage!,
                              fit: BoxFit.cover,
                              width: 72.w,
                              height: 72.w,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Icon(
                                      Icons.person,
                                      size: 36.sp,
                                      color: theme.colorScheme.onPrimaryContainer,
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.person,
                                size: 36.sp,
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 36.sp,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: onEditPressed,
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.cardTheme.color ?? Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.edit_rounded,
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: AppTheme.spacingLg.w),

              // Profile Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      jobTitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            location,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (userType != null && userType!.isNotEmpty) ...[
                      SizedBox(height: AppTheme.spacingSm.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingSm.w,
                          vertical: AppTheme.spacingXs.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getUserTypeColor(userType!).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusFull.r,
                          ),
                          border: Border.all(
                            color: _getUserTypeColor(userType!).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          userType!,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _getUserTypeColor(userType!),
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingLg.h),

          // Profile Strength Banner
          Container(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.15),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profile Strength',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingSm.w,
                        vertical: AppTheme.spacingXs.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusFull.r,
                        ),
                      ),
                      child: Text(
                        _getStrengthLevel(profileStrength),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.spacingSm.h),
                // Progress Bar
                Stack(
                  children: [
                    Container(
                      height: 6.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusFull.r,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: profileStrength / 100,
                      child: Container(
                        height: 6.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primaryColor.withOpacity(0.7),
                              AppTheme.primaryColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusFull.r,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.spacingXs.h),
                Text(
                  '$profileStrength% complete',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getStrengthLevel(int strength) {
    if (strength >= 90) return 'Excellent!';
    if (strength >= 70) return 'Good!';
    if (strength >= 50) return 'Fair';
    return 'Needs Improvement';
  }

  Color _getUserTypeColor(String userType) {
    switch (userType.toUpperCase()) {
      case 'CANDIDATE':
        return const Color(0xFF3B82F6); // Refined Blue
      case 'RECRUITER':
        return const Color(0xFF10B981); // Refined Green
      case 'ADMIN':
        return const Color(0xFFF59E0B); // Refined Orange
      default:
        return Colors.grey;
    }
  }
}

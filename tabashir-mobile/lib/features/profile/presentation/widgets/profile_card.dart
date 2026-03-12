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
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Image
              Stack(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.surfaceContainerHighest,
                    ),
                    child: ClipOval(
                      child: profileImage != null && profileImage!.isNotEmpty
                          ? Image.network(
                              profileImage!,
                              fit: BoxFit.cover,
                              width: 80
                                  .w, // set explicit size to avoid layout issues
                              height: 80.w,
                              // Show placeholder while loading
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Icon(
                                      Icons.person,
                                      size: 40,
                                    );
                                  },
                              // Fallback if the network image fails
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.person,
                                    size: 40,
                                  ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 40,
                            ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: onEditPressed,
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.cardTheme.color ?? Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: AppTheme.spacingMd.w),

              // Profile Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      jobTitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      location,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (userType != null && userType!.isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getUserTypeColor(userType!).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusSmall.r,
                          ),
                          border: Border.all(
                            color: _getUserTypeColor(userType!),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          userType!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _getUserTypeColor(userType!),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingMd.h),

          // Profile Strength Banner
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd.w,
              vertical: AppTheme.spacingSm.h,
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
            child: Row(
              children: [
                Text(
                  '✨',
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(width: AppTheme.spacingSm.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(text: 'Profile Strength: $profileStrength% '),
                        TextSpan(
                          text: '— ${_getStrengthLevel(profileStrength)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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
        return Colors.blue;
      case 'RECRUITER':
        return Colors.green;
      case 'ADMIN':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

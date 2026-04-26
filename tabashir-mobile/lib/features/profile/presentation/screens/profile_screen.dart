import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/constants/countries.dart';

import '../cubit/profile_cubit.dart';
import '../widgets/profile_card.dart';
import '../widgets/info_item.dart';
import '../widgets/menu_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    // Initialize ProfileCubit
    _profileCubit = getIt<ProfileCubit>();
    _profileCubit.loadProfileData();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isAuthenticated = await AuthSessionService.instance.isAuthenticated;
    if (!isAuthenticated && mounted) {
      context.go(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider.value(
      value: _profileCubit,
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final currentTheme = Theme.of(context);

          if (state.status == ProfileStatus.loading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    theme.primaryColor,
                  ),
                ),
              ),
            );
          }

          if (state.status == ProfileStatus.failure) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64.w,
                      color: theme.colorScheme.error,
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),
                    Text(
                      state.errorMessage ?? 'Failed to load profile'.tr(),
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppTheme.spacingLg.h),
                    ElevatedButton(
                      onPressed: () {
                        _profileCubit.loadProfileData();
                      },
                      child: Text('Retry'.tr()),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.requiresReauth) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      size: 64.w,
                      color: theme.colorScheme.error,
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),
                    Text(
                      'Session expired. Please log in again.'.tr(),
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Elaborate Header with gradient background - Consistent with Services screen
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        AppTheme.spacingMd.w,
                        AppTheme.spacingLg.h,
                        AppTheme.spacingMd.w,
                        AppTheme.spacingLg.h,
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
                      child: Row(
                        children: [
                          // Gradient Icon Container
                          Container(
                            padding: EdgeInsets.all(AppTheme.spacingSm.w),
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusMedium.r,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: 24.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: AppTheme.spacingMd.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'My Profile'.tr(),
                                  style: theme.textTheme.displayMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28.sp,
                                        letterSpacing: 0.5,
                                      ),
                                ),
                                SizedBox(height: AppTheme.spacingXs.h),
                                Text(
                                  'Manage your personal information',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: AppTheme.spacingSm.w),
                          // Edit Button
                          Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusMedium.r,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                context.push(
                                  RouteNames.editProfile,
                                  extra: _profileCubit,
                                );
                              },
                              icon: Icon(
                                Icons.edit_rounded,
                                size: 20.sp,
                                color: theme.colorScheme.onSurface,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Profile Card
                    if (state.profile != null) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMd.w,
                        ),
                        child: ProfileCard(
                          name: state.profile!.name,
                          jobTitle: state.profile!.jobTitle,
                          location: state.profile!.location,
                          profileStrength: state.profile!.profileStrength,
                          userType: state.profile!.userType,
                          profileImage: state.profile!.profileImage,
                          onEditPressed: () {
                            context.push(
                              RouteNames.editProfile,
                              extra: _profileCubit,
                            );
                          },
                        ),
                      ),
                    ],

                    SizedBox(height: AppTheme.spacingXl.h),

                    // Personal Information Section
                    if (state.profile != null) ...[
                      _buildSectionHeader(
                        icon: Icons.badge_rounded,
                        title: 'Personal Information',
                        iconColor: AppTheme.primaryColor,
                        iconBgColor: AppTheme.primaryColor.withOpacity(0.1),
                        iconBorderColor: AppTheme.primaryColor.withOpacity(0.2),
                        useGradient: true,
                        theme: currentTheme,
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      InfoItem(
                        icon: Icons.email_outlined,
                        text: state.profile!.email,
                      ),
                      SizedBox(height: AppTheme.spacingSm.h),
                      InfoItem(
                        icon: Icons.public_outlined,
                        text: state.profile!.nationality.isEmpty
                            ? 'Not specified'.tr()
                            : (worldCountries[state.profile!.nationality.toLowerCase()] ?? state.profile!.nationality),
                      ),
                      SizedBox(height: AppTheme.spacingSm.h),
                      InfoItem(
                        icon: Icons.person_outline,
                        text: state.profile!.gender.isEmpty
                            ? 'Not specified'.tr()
                            : state.profile!.gender,
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      // Target Details Section
                      _buildSectionHeader(
                        icon: Icons.work_rounded,
                        title: 'Target Details',
                        iconColor: AppTheme.accentColor,
                        iconBgColor: AppTheme.accentColor.withOpacity(0.1),
                        iconBorderColor: AppTheme.accentColor.withOpacity(0.2),
                        useGradient: true,
                        theme: currentTheme,
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      InfoItem(
                        icon: Icons.location_on_outlined,
                        text: state.profile!.location.isEmpty
                            ? 'Target locations not specified'.tr()
                            : state.profile!.location,
                      ),
                      SizedBox(height: AppTheme.spacingSm.h),
                      InfoItem(
                        icon: Icons.work_outline,
                        text: state.profile!.jobTitle.isEmpty
                            ? 'Target roles not specified'.tr()
                            : state.profile!.jobTitle,
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      // Resume Section
                      _buildSectionHeader(
                        icon: Icons.description_rounded,
                        title: 'Resume / CV',
                        iconColor: AppTheme.successColor,
                        iconBgColor: AppTheme.successColor.withOpacity(0.1),
                        iconBorderColor: AppTheme.successColor.withOpacity(0.2),
                        useGradient: true,
                        theme: currentTheme,
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      if (state.profile!.cvFilename != null &&
                          state.profile!.cvFilename!.isNotEmpty)
                        InfoItem(
                          icon: Icons.description_rounded,
                          text: state.profile!.cvFilename!,
                          trailing: Icon(
                            Icons.check_circle_rounded,
                            color: AppTheme.successColor,
                            size: 20.sp,
                          ),
                        )
                      else
                        InfoItem(
                          icon: Icons.description_outlined,
                          text: 'No resume uploaded'.tr(),
                          trailing: Icon(
                            Icons.error_outline_rounded,
                            color: AppTheme.warningColor,
                            size: 20.sp,
                          ),
                        ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      // Account Section
                      _buildSectionHeader(
                        icon: Icons.shield_rounded,
                        title: 'Account',
                        iconColor: AppTheme.warningColor,
                        iconBgColor: AppTheme.warningColor.withOpacity(0.1),
                        iconBorderColor: AppTheme.warningColor.withOpacity(0.2),
                        useGradient: true,
                        theme: currentTheme,
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      // Change Password - Hidden
                      // MenuTile(
                      //   icon: Icons.lock_outline,
                      //   text: 'Change Password'.tr(),
                      //   trailing: const SizedBox(),
                      //   onTap: () {
                      //     context.push(RouteNames.changePassword);
                      //   },
                      // ),
                      // SizedBox(height: AppTheme.spacingSm.h),
                      MenuTile(
                        icon: Icons.settings_outlined,
                        text: 'Settings'.tr(),
                        trailing: const SizedBox(),
                        onTap: () {
                          context.push(RouteNames.settings);
                        },
                      ),
                      SizedBox(height: AppTheme.spacingSm.h),
                      MenuTile(
                        icon: Icons.logout,
                        text: 'Logout'.tr(),
                        showLogoutColor: true,
                        trailing: const SizedBox(),
                        onTap: () async {
                          final shouldLogout = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Logout'.tr()),
                              content: Text(
                                'Are you sure you want to logout?'.tr(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Cancel'.tr()),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text('Logout'.tr()),
                                ),
                              ],
                            ),
                          );

                          if (shouldLogout ?? false) {
                            await _profileCubit.logout();
                            if (mounted) {
                              context.go(RouteNames.login);
                            }
                          }
                        },
                      ),
                      SizedBox(height: AppTheme.spacingSm.h),
                      MenuTile(
                        icon: Icons.delete_outline,
                        text: 'Delete Account'.tr(),
                        showLogoutColor: true,
                        trailing: const SizedBox(),
                        onTap: () async {
                          final shouldDelete = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Delete Account'.tr(),
                                style: const TextStyle(color: Colors.red),
                              ),
                              content: Text(
                                'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.'
                                    .tr(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Cancel'.tr()),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: Text('Delete'.tr()),
                                ),
                              ],
                            ),
                          );

                          if (shouldDelete ?? false) {
                            await _profileCubit.deleteAccount();
                            if (mounted) {
                              context.go(RouteNames.login);
                            }
                          }
                        },
                      ),
                    ],

                    SizedBox(
                      height: kBottomNavigationBarHeight + AppTheme.spacingLg.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds a section header with icon - Consistent with Home screen pattern
  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color iconColor,
    required Color iconBgColor,
    required Color iconBorderColor,
    required ThemeData theme,
    bool useGradient = false,
  }) => Padding(
    padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppTheme.spacingSm.w),
          decoration: BoxDecoration(
            gradient: useGradient ? AppTheme.primaryGradient : null,
            color: useGradient ? null : iconBgColor,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: useGradient
                ? null
                : Border.all(
                    color: iconBorderColor,
                  ),
            boxShadow: useGradient
                ? [
                    BoxShadow(
                      color: iconColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: 20.sp,
            color: useGradient ? Colors.white : iconColor,
          ),
        ),
        SizedBox(width: AppTheme.spacingMd.w),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
      ],
    ),
  );
}

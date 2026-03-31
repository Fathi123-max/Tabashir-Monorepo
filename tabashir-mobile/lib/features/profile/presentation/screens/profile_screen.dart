import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/features/profile/domain/repositories/profile_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/route_names.dart';
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
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.spacingMd.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'My Profile'.tr(),
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.push(
                                RouteNames.editProfile,
                                extra: _profileCubit,
                              );
                            },
                            icon: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withOpacity(
                                  0.1,
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.edit_outlined,
                                color: theme.colorScheme.primary,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),

                      // Profile Card
                      if (state.profile != null) ...[
                        ProfileCard(
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
                      ],

                      SizedBox(height: AppTheme.spacingLg.h),

                      // Personal Information Section
                      if (state.profile != null) ...[
                        _sectionHeader('Personal Information'.tr(), theme),
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
                              : state.profile!.nationality,
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
                        InfoItem(
                          icon: Icons.person_outline,
                          text: state.profile!.gender.isEmpty
                              ? 'Not specified'.tr()
                              : state.profile!.gender,
                        ),
                        SizedBox(height: AppTheme.spacingLg.h),

                        // Target Details Section
                        _sectionHeader('Target Details'.tr(), theme),
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
                        SizedBox(height: AppTheme.spacingLg.h),

                        // Resume Section
                        _sectionHeader('Resume / CV'.tr(), theme),
                        SizedBox(height: AppTheme.spacingMd.h),
                        state.profile!.cvFilename != null &&
                                state.profile!.cvFilename!.isNotEmpty
                            ? InfoItem(
                                icon: Icons.description_outlined,
                                text: state.profile!.cvFilename!,
                                trailing: Icon(
                                  Icons.check_circle_outline,
                                  color: theme.colorScheme.primary,
                                  size: 20.sp,
                                ),
                              )
                            : InfoItem(
                                icon: Icons.description_outlined,
                                text: 'No resume uploaded'.tr(),
                                trailing: Icon(
                                  Icons.error_outline,
                                  color: Colors.orange,
                                  size: 20.sp,
                                ),
                              ),
                        SizedBox(height: AppTheme.spacingLg.h),

                        // Account Section
                        _sectionHeader('Account'.tr(), theme),
                        SizedBox(height: AppTheme.spacingMd.h),
                        MenuTile(
                          icon: Icons.lock_outline,
                          text: 'Change Password'.tr(),
                          trailing: const SizedBox(),
                          onTap: () {
                            context.push(RouteNames.changePassword);
                          },
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
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
                        height:
                            kBottomNavigationBarHeight + AppTheme.spacingLg.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionHeader(String title, ThemeData theme) => Padding(
    padding: EdgeInsets.only(left: 4.w, bottom: 4.h),
    child: Text(
      title,
      style: theme.textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface.withOpacity(0.5),
        letterSpacing: 1.2,
      ),
    ),
  );
}

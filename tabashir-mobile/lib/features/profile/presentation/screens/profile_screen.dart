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

          if (state.requiresReauth == true) {
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
                      Text(
                        'My Profile'.tr(),
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
                          onEdit: () {
                            context.push(
                              RouteNames.editProfile,
                              extra: _profileCubit,
                            );
                          },
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
                        InfoItem(
                          icon: Icons.phone_outlined,
                          text: state.profile!.phone.isEmpty
                              ? 'Not specified'.tr()
                              : state.profile!.phone,
                          onEdit: () {
                            context.push(
                              RouteNames.editProfile,
                              extra: _profileCubit,
                            );
                          },
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
                        InfoItem(
                          icon: Icons.public_outlined,
                          text: state.profile!.nationality.isEmpty
                              ? 'Not specified'.tr()
                              : state.profile!.nationality,
                          onEdit: () {
                            context.push(
                              RouteNames.editProfile,
                              extra: _profileCubit,
                            );
                          },
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
                        InfoItem(
                          icon: Icons.person_outline,
                          text: state.profile!.gender.isEmpty
                              ? 'Not specified'.tr()
                              : state.profile!.gender,
                          onEdit: () {
                            context.push(
                              RouteNames.editProfile,
                              extra: _profileCubit,
                            );
                          },
                        ),
                        SizedBox(height: AppTheme.spacingLg.h),

                        // Professional Details Section
                        _sectionHeader('Professional Details'.tr(), theme),
                        SizedBox(height: AppTheme.spacingMd.h),
                        InfoItem(
                          icon: Icons.work_outline,
                          text: state.profile!.company.isEmpty
                              ? 'Not specified'.tr()
                              : state.profile!.company,
                          onEdit: () {
                            context.push(
                              RouteNames.editProfile,
                              extra: _profileCubit,
                            );
                          },
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
                        InfoItem(
                          icon: Icons.school_outlined,
                          text: state.profile!.education.isEmpty
                              ? 'Not specified'.tr()
                              : state.profile!.education,
                          onEdit: () {
                            context.push(
                              RouteNames.editProfile,
                              extra: _profileCubit,
                            );
                          },
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
                        InfoItem(
                          icon: Icons.link,
                          text: state.profile!.linkedin.isEmpty
                              ? 'Not specified'.tr()
                              : state.profile!.linkedin,
                          onEdit: () {
                            context.push(
                              RouteNames.editProfile,
                              extra: _profileCubit,
                            );
                          },
                        ),
                        SizedBox(height: AppTheme.spacingLg.h),

                        // // Account Activity Section
                        // _sectionHeader('Account Activity'.tr(), theme),
                        // SizedBox(height: AppTheme.spacingMd.h),
                        // InfoItem(
                        //   icon: Icons.description_outlined,
                        //   text:
                        //       'Total Resumes: ${state.profile!.totalResumes ?? 0}',
                        //   onEdit: null,
                        // ),
                        // SizedBox(height: AppTheme.spacingSm.h),
                        // InfoItem(
                        //   icon: Icons.assignment_turned_in_outlined,
                        //   text:
                        //       'Total Applications: ${state.profile!.totalApplications ?? 0}',
                        //   onEdit: null,
                        // ),
                        // SizedBox(height: AppTheme.spacingSm.h),
                        // InfoItem(
                        //   icon: Icons.bookmark_outline,
                        //   text: 'Saved Jobs: ${state.profile!.savedJobs ?? 0}',
                        //   onEdit: null,
                        // ),
                        // SizedBox(height: AppTheme.spacingLg.h),

                        // // Subscription & Billing Section
                        // if (state.profile!.subscriptionPlan != null ||
                        //     state.profile!.paymentStats != null) ...[
                        //   _sectionHeader('Subscription & Billing'.tr(), theme),
                        //   SizedBox(height: AppTheme.spacingMd.h),
                        //   if (state.profile!.subscriptionPlan != null) ...[
                        //     InfoItem(
                        //       icon: Icons.workspace_premium_outlined,
                        //       text: 'Plan: ${state.profile!.subscriptionPlan}',
                        //       trailing: Container(
                        //         padding: EdgeInsets.symmetric(
                        //           horizontal: 12.w,
                        //           vertical: 4.h,
                        //         ),
                        //         decoration: BoxDecoration(
                        //           color:
                        //               (state.profile!.subscriptionStatus ==
                        //                   'ACTIVE')
                        //               ? Colors.green.withOpacity(0.1)
                        //               : Colors.red.withOpacity(0.1),
                        //           borderRadius: BorderRadius.circular(
                        //             AppTheme.radiusSmall,
                        //           ),
                        //         ),
                        //         child: Text(
                        //           state.profile!.subscriptionStatus ?? '',
                        //           style: theme.textTheme.bodySmall?.copyWith(
                        //             color:
                        //                 (state.profile!.subscriptionStatus ==
                        //                     'ACTIVE')
                        //                 ? Colors.green
                        //                 : Colors.red,
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //         ),
                        //       ),
                        //       onEdit: null,
                        //     ),
                        //     SizedBox(height: AppTheme.spacingSm.h),
                        //   ],
                        //   if (state.profile!.paymentStats != null) ...[
                        //     InfoItem(
                        //       icon: Icons.credit_card_outlined,
                        //       text:
                        //           'Total Spent: ${state.profile!.paymentStats!.totalAmountSpent} ${state.profile!.paymentStats!.currency ?? "AED"}',
                        //       onEdit: null,
                        //     ),
                        //     SizedBox(height: AppTheme.spacingSm.h),
                        //     InfoItem(
                        //       icon: Icons.receipt_long_outlined,
                        //       text:
                        //           'Total Payments: ${state.profile!.paymentStats!.totalPayments}',
                        //       onEdit: null,
                        //     ),
                        //   ],
                        //   SizedBox(height: AppTheme.spacingLg.h),
                        // ],

                        // // Job Statistics Section (Recruiters/Admins)
                        // if (state.profile!.userType == 'RECRUITER' ||
                        //     state.profile!.userType == 'ADMIN') ...[
                        //   _sectionHeader('Job Statistics'.tr(), theme),
                        //   SizedBox(height: AppTheme.spacingMd.h),
                        //   if (state.profile!.jobStats != null) ...[
                        //     InfoItem(
                        //       icon: Icons.work_outline,
                        //       text:
                        //           'Total Jobs: ${state.profile!.jobStats!.totalJobs}',
                        //       onEdit: null,
                        //     ),
                        //     SizedBox(height: AppTheme.spacingSm.h),
                        //     InfoItem(
                        //       icon: Icons.play_circle_outline,
                        //       text:
                        //           'Active Jobs: ${state.profile!.jobStats!.activeJobs}',
                        //       onEdit: null,
                        //     ),
                        //     SizedBox(height: AppTheme.spacingSm.h),
                        //     InfoItem(
                        //       icon: Icons.people_outline,
                        //       text:
                        //           'Applications Received: ${state.profile!.jobStats!.applicationsReceived}',
                        //       onEdit: null,
                        //     ),
                        //   ],
                        //   SizedBox(height: AppTheme.spacingLg.h),
                        // ],

                        // // AI Resume Statistics Section (Candidates)
                        // if (state.profile!.userType == 'CANDIDATE' &&
                        //     state.profile!.aiResumeStats != null) ...[
                        //   _sectionHeader('AI Resume Statistics'.tr(), theme),
                        //   SizedBox(height: AppTheme.spacingMd.h),
                        //   InfoItem(
                        //     icon: Icons.psychology_outlined,
                        //     text:
                        //         'Total AI Resumes: ${state.profile!.aiResumeStats!.total}',
                        //     onEdit: null,
                        //   ),
                        //   SizedBox(height: AppTheme.spacingSm.h),
                        //   InfoItem(
                        //     icon: Icons.drafts_outlined,
                        //     text:
                        //         'Draft: ${state.profile!.aiResumeStats!.draft}',
                        //     onEdit: null,
                        //   ),
                        //   SizedBox(height: AppTheme.spacingSm.h),
                        //   InfoItem(
                        //     icon: Icons.hourglass_top_outlined,
                        //     text:
                        //         'In Progress: ${state.profile!.aiResumeStats!.inProgress}',
                        //     onEdit: null,
                        //   ),
                        //   SizedBox(height: AppTheme.spacingSm.h),
                        //   InfoItem(
                        //     icon: Icons.check_circle_outline,
                        //     text:
                        //         'Completed: ${state.profile!.aiResumeStats!.completed}',
                        //     onEdit: null,
                        //   ),
                        //   SizedBox(height: AppTheme.spacingLg.h),
                        // ],

                        // // Admin Permissions Section (Admins Only)
                        // if (state.profile!.userType == 'ADMIN' &&
                        //     state.profile!.adminPermissions.isNotEmpty) ...[
                        //   _sectionHeader('Admin Permissions'.tr(), theme),
                        //   SizedBox(height: AppTheme.spacingMd.h),
                        //   Container(
                        //     padding: EdgeInsets.all(AppTheme.spacingMd.w),
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey[50],
                        //       borderRadius: BorderRadius.circular(
                        //         AppTheme.radiusDefault,
                        //       ),
                        //     ),
                        //     child: Column(
                        //       children: state.profile!.adminPermissions.map((
                        //         permission,
                        //       ) {
                        //         return Padding(
                        //           padding: EdgeInsets.symmetric(
                        //             vertical: 4.h,
                        //           ),
                        //           child: Row(
                        //             children: [
                        //               Icon(
                        //                 Icons.check_circle,
                        //                 color: Colors.green,
                        //                 size: 20.w,
                        //               ),
                        //               SizedBox(width: AppTheme.spacingSm.w),
                        //               Expanded(
                        //                 child: Text(
                        //                   permission
                        //                       .replaceAll('_', ' ')
                        //                       .toUpperCase(),
                        //                   style: theme.textTheme.bodyMedium,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         );
                        //       }).toList(),
                        //     ),
                        //   ),
                        //   SizedBox(height: AppTheme.spacingLg.h),
                        // ],

                        // Security & Privacy Section
                        // _sectionHeader('Security & Privacy'.tr(), theme),
                        // SizedBox(height: AppTheme.spacingMd.h),
                        // if (state.profile!.security != null) ...[
                        //   InfoItem(
                        //     icon: Icons.security_outlined,
                        //     text:
                        //         'Active Sessions: ${state.profile!.security!.activeSessions}',
                        //     onEdit: null,
                        //   ),
                        //   SizedBox(height: AppTheme.spacingSm.h),
                        // ],
                        // if (state.profile!.connectedAccounts.isNotEmpty) ...[
                        //   InfoItem(
                        //     icon: Icons.link_outlined,
                        //     text:
                        //         'Connected Accounts: ${state.profile!.connectedAccounts.map((a) => a.provider).join(", ")}',
                        //     onEdit: null,
                        //   ),
                        // ],
                        // SizedBox(height: AppTheme.spacingLg.h),

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

  Widget _sectionHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

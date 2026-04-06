import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tabashir/core/constants/storage_keys.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/theme/theme_manager.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/features/profile/presentation/widgets/menu_tile.dart';
import 'package:tabashir/core/services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = true;
  bool _smsNotificationsEnabled = false;
  final bool _biometricEnabled = true;
  late final ThemeManager _themeManager;

  @override
  void initState() {
    super.initState();
    _themeManager = ThemeManager();
    _loadNotificationPreferences();
  }

  // Load notification preferences from shared preferences
  Future<void> _loadNotificationPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _pushNotificationsEnabled =
          prefs.getBool(StorageKeys.enablePushNotifications) ?? true;
      _emailNotificationsEnabled =
          prefs.getBool(StorageKeys.enableEmailNotifications) ?? true;
      _smsNotificationsEnabled =
          prefs.getBool('enable_sms_notifications') ?? false;
    });
  }

  // Save push notification preference
  Future<void> _savePushNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.enablePushNotifications, value);

    // Update OneSignal subscription based on user preference
    if (value) {
      await NotificationService.instance.optIn();
    } else {
      await NotificationService.instance.optOut();
    }
  }

  // Save email notification preference
  Future<void> _saveEmailNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(StorageKeys.enableEmailNotifications, value);
  }

  // Save SMS notification preference
  Future<void> _saveSMSNotificationPreference(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('enable_sms_notifications', value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Settings'.tr(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications Section - Hidden
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
            //   child: Text(
            //     'Notifications'.tr(),
            //     style: theme.textTheme.titleLarge?.copyWith(
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // SizedBox(height: AppTheme.spacingMd.h),

            // MenuTile(
            //   icon: Icons.notifications_outlined,
            //   text: 'Push Notifications'.tr(),
            //   trailing: Switch(
            //     value: _pushNotificationsEnabled,
            //     onChanged: (value) async {
            //       setState(() {
            //         _pushNotificationsEnabled = value;
            //       });
            //       await _savePushNotificationPreference(value);
            //     },
            //     activeThumbColor: AppTheme.primaryColor,
            //   ),
            //   onTap: () async {
            //     setState(() {
            //       _pushNotificationsEnabled = !_pushNotificationsEnabled;
            //     });
            //     await _savePushNotificationPreference(
            //       _pushNotificationsEnabled,
            //     );
            //   },
            // ),
            // SizedBox(height: AppTheme.spacingSm.h),

            // Appearance Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
              child: Text(
                'Appearance'.tr(),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            AnimatedBuilder(
              animation: _themeManager,
              builder: (context, child) {
                final isDarkMode = _themeManager.isDarkMode;
                return MenuTile(
                  icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  text: 'Dark Mode'.tr(),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      _themeManager.themeMode = value
                          ? ThemeMode.dark
                          : ThemeMode.light;
                      _themeManager.savePreferences();
                      _showThemeChangeDialog(value);
                    },
                    activeThumbColor: AppTheme.primaryColor,
                  ),
                  onTap: () {
                    _themeManager.toggleTheme();
                    _themeManager.savePreferences();
                    _showThemeChangeDialog(_themeManager.isDarkMode);
                  },
                );
              },
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Language Section
            MenuTile(
              icon: Icons.language_outlined,
              text: 'Language'.tr(),
              trailing: PopupMenuButton<Locale>(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                onSelected: (locale) {
                  context.setLocale(locale);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Language changed to ${locale.languageCode == 'en'
                                ? 'English'
                                : locale.languageCode == 'ar'
                                ? 'العربية'
                                : 'Español'}'
                            .tr(),
                      ),
                      backgroundColor: AppTheme.primaryColor,
                    ),
                  );
                },
                itemBuilder: (context) => [
                  PopupMenuItem<Locale>(
                    value: const Locale('en'),
                    child: Row(
                      children: [
                        Text('English'.tr()),
                        const Spacer(),
                        if (context.locale.languageCode == 'en')
                          Icon(
                            Icons.check_circle,
                            color: AppTheme.primaryColor,
                            size: 20.sp,
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem<Locale>(
                    value: const Locale('ar'),
                    child: Row(
                      children: [
                        const Text('العربية'),
                        const Spacer(),
                        if (context.locale.languageCode == 'ar')
                          Icon(
                            Icons.check_circle,
                            color: AppTheme.primaryColor,
                            size: 20.sp,
                          ),
                      ],
                    ),
                  ),
                  PopupMenuItem<Locale>(
                    value: const Locale('es'),
                    child: Row(
                      children: [
                        const Text('Español'),
                        const Spacer(),
                        if (context.locale.languageCode == 'es')
                          Icon(
                            Icons.check_circle,
                            color: AppTheme.primaryColor,
                            size: 20.sp,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Language selection handled by PopupMenuButton
              },
            ),
            SizedBox(height: AppTheme.spacingLg.h),

            // Privacy Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
              child: Text(
                'Privacy & Data'.tr(),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            MenuTile(
              icon: Icons.privacy_tip_outlined,
              text: 'Privacy Policy'.tr(),
              onTap: () async {
                final uri = Uri.parse(
                  'https://www.tabashir.ae/en/privacy-policy',
                );
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not open Privacy Policy'.tr()),
                        backgroundColor: AppTheme.errorColor,
                      ),
                    );
                  }
                }
              },
            ),
            SizedBox(height: AppTheme.spacingSm.h),

            MenuTile(
              icon: Icons.description_outlined,
              text: 'Terms of Service'.tr(),
              onTap: () async {
                final uri = Uri.parse(
                  'https://www.tabashir.ae/en/terms-and-condition',
                );
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Could not open Terms of Service'.tr(),
                        ),
                        backgroundColor: AppTheme.errorColor,
                      ),
                    );
                  }
                }
              },
            ),
            SizedBox(height: AppTheme.spacingSm.h),

            // Contact Support
            MenuTile(
              icon: Icons.support_agent_outlined,
              text: 'Contact Support'.tr(),
              onTap: () async {
                final uri = Uri.parse(
                  'mailto:support@tabashir.com?subject=Tabashir%20Support%20Request',
                );
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Support email: support@tabashir.com'.tr(),
                        ),
                        backgroundColor: AppTheme.warningColor,
                      ),
                    );
                  }
                }
              },
            ),
            SizedBox(height: AppTheme.spacingSm.h),

            // Delete Account
            MenuTile(
              icon: Icons.delete_forever,
              text: 'Delete Account'.tr(),
              showLogoutColor: true,
              onTap: _showDeleteAccountDialog,
            ),
            SizedBox(height: AppTheme.spacingLg.h),

            // App Information Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
              child: Text(
                'App Information'.tr(),
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            MenuTile(
              icon: Icons.info_outline,
              text: 'About Tabashir'.tr(),
              onTap: _showAboutDialog,
            ),
            SizedBox(height: AppTheme.spacingSm.h),

            // Rate the App - Hidden
            // MenuTile(
            //   icon: Icons.star_outline,
            //   text: 'Rate the App'.tr(),
            //   onTap: () {
            //     _showComingSoonDialog('Rate the App'.tr());
            //   },
            // ),
            // SizedBox(height: AppTheme.spacingSm.h),

            // Share with Friends - Hidden
            // MenuTile(
            //   icon: Icons.share_outlined,
            //   text: 'Share with Friends'.tr(),
            //   onTap: () {
            //     _showComingSoonDialog('Share with Friends'.tr());
            //   },
            // ),
            SizedBox(
              height: kBottomNavigationBarHeight + AppTheme.spacingLg.h,
            ),
          ],
        ),
      ),
    );
  }

  void _showTwoFactorDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Two-Factor Authentication'.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Two-factor authentication adds an extra layer of security to your account. You will receive a code via SMS or authenticator app.'
              .tr(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showComingSoonDialog('Two-Factor Authentication'.tr());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('Enable'.tr()),
          ),
        ],
      ),
    );
  }

  void _showThemeChangeDialog(bool isDarkMode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Theme changed to ${isDarkMode ? '.tr()Dark' : '.tr()Light'} mode'
              .tr(),
        ),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear Cache'.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Are you sure you want to clear the app cache? This will remove temporary files and may improve performance.'
              .tr(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Cache cleared successfully'.tr()),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('Clear'.tr()),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    final profileCubit = getIt<ProfileCubit>();
    
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Account'.tr(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.errorColor,
          ),
        ),
        content: Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.'
              .tr(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              
              // Show loading
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
              
              try {
                await profileCubit.deleteAccount();
                
                if (mounted) {
                  Navigator.pop(context); // Close loading
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Account deleted successfully'.tr()),
                      backgroundColor: AppTheme.successColor,
                    ),
                  );
                  
                  // Navigate to login/logout
                  context.go('/${RouteNames.login}');
                }
              } catch (e) {
                if (mounted) {
                  Navigator.pop(context); // Close loading
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete account: $e'.tr()),
                      backgroundColor: AppTheme.errorColor,
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              foregroundColor: Colors.white,
            ),
            child: Text('Delete'.tr()),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'About Tabashir'.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version 1.0.0'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Tabashir is your AI-powered job search companion. Find your dream job and build the perfect resume with our advanced features.'
                  .tr(),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('Close'.tr()),
          ),
        ],
      ),
    );
  }

  void _showComingSoonDialog(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature feature coming soon!'.tr()),
        backgroundColor: AppTheme.warningColor,
      ),
    );
  }
}

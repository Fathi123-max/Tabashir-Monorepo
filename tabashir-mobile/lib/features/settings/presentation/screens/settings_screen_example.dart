import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/settings/domain/repositories/settings_repository.dart';
import 'package:tabashir/features/settings/presentation/cubit/settings_cubit.dart';

/// Example usage of SettingsCubit in a screen
class SettingsScreenExample extends StatelessWidget {
  const SettingsScreenExample({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => SettingsCubit(
      getIt<SettingsRepository>(),
    )..loadSettings(),
    child: const SettingsView(),
  );
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Settings'),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            context.read<SettingsCubit>().loadSettings();
          },
        ),
      ],
    ),
    body: BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<SettingsCubit>().loadSettings();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return ListView(
          children: [
            // Notifications Section
            _SettingsSection(
              title: 'Notifications',
              children: [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    final notificationsEnabled =
                        (state.settings['notifications_enabled'] as bool?) ??
                        true;

                    return SwitchListTile(
                      title: const Text('Enable Notifications'),
                      value: notificationsEnabled,
                      onChanged: (value) {
                        context.read<SettingsCubit>().setSetting(
                          key: 'notifications_enabled',
                          value: value,
                        );
                      },
                      secondary: const Icon(Icons.notifications),
                    );
                  },
                ),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    final emailEnabled =
                        (state.settings['email_notifications'] as bool?) ??
                        true;

                    return SwitchListTile(
                      title: const Text('Email Notifications'),
                      value: emailEnabled,
                      onChanged: (value) {
                        context.read<SettingsCubit>().setSetting(
                          key: 'email_notifications',
                          value: value,
                        );
                      },
                      secondary: const Icon(Icons.email),
                    );
                  },
                ),
              ],
            ),
            // Theme Section
            _SettingsSection(
              title: 'Appearance',
              children: [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    final darkMode =
                        (state.settings['dark_mode'] as bool?) ?? false;

                    return SwitchListTile(
                      title: const Text('Dark Mode'),
                      value: darkMode,
                      onChanged: (value) {
                        context.read<SettingsCubit>().toggleSetting(
                          key: 'dark_mode',
                        );
                      },
                      secondary: const Icon(Icons.dark_mode),
                    );
                  },
                ),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    final language =
                        state.settings['language'] as String? ?? 'English';

                    return ListTile(
                      title: const Text('Language'),
                      subtitle: Text(language),
                      leading: const Icon(Icons.language),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Show language picker
                        _showLanguagePicker(context);
                      },
                    );
                  },
                ),
              ],
            ),
            // Privacy Section
            _SettingsSection(
              title: 'Privacy',
              children: [
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) {
                    final publicProfile =
                        (state.settings['public_profile'] as bool?) ?? true;

                    return SwitchListTile(
                      title: const Text('Public Profile'),
                      subtitle: const Text(
                        'Make your profile visible to others',
                      ),
                      value: publicProfile,
                      onChanged: (value) {
                        context.read<SettingsCubit>().setSetting(
                          key: 'public_profile',
                          value: value,
                        );
                      },
                      secondary: const Icon(Icons.public),
                    );
                  },
                ),
              ],
            ),
            // Data & Storage Section
            _SettingsSection(
              title: 'Data & Storage',
              children: [
                ListTile(
                  title: const Text('Clear Cache'),
                  subtitle: const Text('Free up storage space'),
                  leading: const Icon(Icons.cleaning_services),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    context.read<SettingsCubit>().setSetting(
                      key: 'cache_cleared_at',
                      value: DateTime.now().toIso8601String(),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cache cleared successfully'),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Reset All Settings'),
                  subtitle: const Text('Restore default settings'),
                  leading: const Icon(Icons.restore, color: Colors.red),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showResetConfirmation(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  void _showLanguagePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                context.read<SettingsCubit>().setSetting(
                  key: 'language',
                  value: 'English',
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Arabic'),
              onTap: () {
                context.read<SettingsCubit>().setSetting(
                  key: 'language',
                  value: 'Arabic',
                );
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('French'),
              onTap: () {
                context.read<SettingsCubit>().setSetting(
                  key: 'language',
                  value: 'French',
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showResetConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'Are you sure you want to reset all settings to default? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SettingsCubit>().clearSettings();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings reset to default'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({
    required this.title,
    required this.children,
  });
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
      ...children,
      const Divider(),
    ],
  );
}

/// Simple settings example with reactive forms
class SimpleSettingsScreen extends StatelessWidget {
  const SimpleSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => SettingsCubit(
      getIt<SettingsRepository>(),
    )..loadSettings(),
    child: const SimpleSettingsView(),
  );
}

class SimpleSettingsView extends StatelessWidget {
  const SimpleSettingsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Settings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Username setting
            TextFormField(
              initialValue: state.settings['username'] as String? ?? '',
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              onFieldSubmitted: (value) {
                context.read<SettingsCubit>().setSetting(
                  key: 'username',
                  value: value,
                );
              },
            ),
            const SizedBox(height: 16),
            // Email setting
            TextFormField(
              initialValue: state.settings['email'] as String? ?? '',
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onFieldSubmitted: (value) {
                context.read<SettingsCubit>().setSetting(
                  key: 'email',
                  value: value,
                );
              },
            ),
            const SizedBox(height: 16),
            // Auto-apply setting
            SwitchListTile(
              title: const Text('Auto-apply to Jobs'),
              value: (state.settings['auto_apply'] as bool?) ?? false,
              onChanged: (value) {
                context.read<SettingsCubit>().setSetting(
                  key: 'auto_apply',
                  value: value,
                );
              },
            ),
            const SizedBox(height: 16),
            // Save button
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Settings saved'),
                  ),
                );
              },
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    ),
  );
}

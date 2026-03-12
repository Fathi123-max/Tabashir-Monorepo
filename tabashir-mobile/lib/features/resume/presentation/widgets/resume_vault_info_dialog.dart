import 'package:flutter/material.dart';

/// Widget for displaying info dialog about Resume Vault
class ResumeVaultInfoDialog extends StatelessWidget {
  const ResumeVaultInfoDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => const ResumeVaultInfoDialog(),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.cardTheme.color,
      title: const Text('Resume Vault'),
      content: const Text(
        'Your resume vault stores all your resume versions. You can add multiple resumes, set a default one, and manage them easily. Your resumes are private and only visible to you.',
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Got it'),
        ),
      ],
    );
  }
}

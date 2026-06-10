import 'package:easy_localization/easy_localization.dart';
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
      title: Text('resume_vault_info_title'.tr()),
      content: Text(
        'resume_vault_info_content'.tr(),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('got_it'.tr()),
        ),
      ],
    );
  }
}

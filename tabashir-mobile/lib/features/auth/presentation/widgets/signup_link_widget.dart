import 'package:flutter/material.dart';

class SignupLinkWidget extends StatelessWidget {
  const SignupLinkWidget({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: RichText(
        text: TextSpan(
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          children: [
            const TextSpan(text: "Don't have an account? "),
            WidgetSpan(
              child: GestureDetector(
                onTap: onTap,
                child: Text(
                  'Create one',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

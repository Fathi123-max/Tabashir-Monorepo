import 'package:flutter/material.dart';

/// Custom dialog widget
class CustomDialog extends StatelessWidget {
  const CustomDialog({
    required this.title,
    required this.content,
    super.key,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.contentWidget,
    this.showCancelButton = true,
  });
  final String title;
  final String content;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Widget? contentWidget;
  final bool showCancelButton;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    content:
        contentWidget ??
        Text(
          content,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
    actions: [
      if (showCancelButton)
        TextButton(
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            cancelText!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      TextButton(
        onPressed: () {
          if (onConfirm != null) {
            onConfirm!();
          } else {
            Navigator.of(context).pop();
          }
        },
        child: Text(
          confirmText!,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    ],
  );
}

/// Loading dialog widget
class LoadingDialog extends StatelessWidget {
  const LoadingDialog({
    super.key,
    this.message = 'Loading...',
  });
  final String message;

  @override
  Widget build(BuildContext context) => AlertDialog(
    content: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(width: 16),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  );
}

/// Confirmation dialog widget
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
    super.key,
    this.confirmText = 'Yes',
    this.cancelText = 'No',
    this.onCancel,
  });
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    content: Text(
      content,
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    actions: [
      TextButton(
        onPressed: () {
          if (onCancel != null) {
            onCancel!();
          }
          Navigator.of(context).pop();
        },
        child: Text(
          cancelText,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      TextButton(
        onPressed: () {
          onConfirm();
          Navigator.of(context).pop();
        },
        child: Text(
          confirmText,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Custom loading indicator
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.message,
    this.size = 40.0,
    this.color,
  });
  final String? message;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loaderColor = color ?? theme.colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
            strokeWidth: 3,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }
}

/// Full screen loader widget
class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({
    super.key,
    this.message = 'Loading...',
  });
  final String message;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Colors.black.withOpacity(0.1),
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: LoadingIndicator(message: message),
      ),
    ),
  );
}

/// Shimmer loading widget
class ShimmerLoader extends StatelessWidget {
  const ShimmerLoader({
    required this.child,
    super.key,
    this.lines = 3,
    this.lineHeight = 16,
    this.padding,
    this.isLoading = true,
  });
  final Widget child;
  final int lines;
  final double lineHeight;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }

    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      highlightColor: Theme.of(context).colorScheme.surface,
      child: Container(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            lines,
            (index) => Container(
              width: index == 0 ? double.infinity : (index == 1 ? 200 : 150),
              height: lineHeight,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
              margin: const EdgeInsets.only(bottom: 8),
            ),
          ),
        ),
      ),
    );
  }
}

/// List item shimmer loader
class ListItemShimmerLoader extends StatelessWidget {
  const ListItemShimmerLoader({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
  });
  final int itemCount;
  final double itemHeight;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    highlightColor: Theme.of(context).colorScheme.surface,
    child: ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Container(
        height: itemHeight,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

/// Custom progress indicator
class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    required this.label,
    required this.progress,
    super.key,
    this.height = 8,
    this.backgroundColor,
    this.progressColor,
  });
  final String label;
  final double progress;
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor =
        backgroundColor ??
        theme.colorScheme.surfaceContainerHighest.withOpacity(0.5);
    final progColor = progressColor ?? theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall,
            ),
            Text(
              '${(progress * 100).round()}%',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(height / 2),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(progColor),
            ),
          ),
        ),
      ],
    );
  }
}

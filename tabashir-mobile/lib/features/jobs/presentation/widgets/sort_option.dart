import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class SortOption extends StatelessWidget {
  const SortOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.spacingSm.w,
        ),
        decoration: BoxDecoration(
          color: isSelected ? theme.cardTheme.color : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isSelected
                  ? theme.textTheme.bodyLarge?.color
                  : theme.colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

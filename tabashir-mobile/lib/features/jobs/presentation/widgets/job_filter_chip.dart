import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class FilterChip extends StatelessWidget {
  const FilterChip({
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
          horizontal: AppTheme.spacingMd.w,
          vertical: AppTheme.spacingSm.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryColor
              : theme.inputDecorationTheme.fillColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryColor
                : theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

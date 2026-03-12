import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
  });
  final String? label;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacingXs.h),
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          enabled: enabled,
          maxLines: maxLines,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: enabled
                ? (theme.brightness == Brightness.light
                      ? const Color(0xFFF1F5F9)
                      : const Color(0xFF1E293B))
                : (theme.brightness == Brightness.light
                      ? const Color(0xFFE2E8F0)
                      : const Color(0xFF334155)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              borderSide: BorderSide(
                color: theme.brightness == Brightness.light
                    ? AppTheme.borderLight
                    : AppTheme.borderDark,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              borderSide: BorderSide(
                color: theme.brightness == Brightness.light
                    ? AppTheme.borderLight
                    : AppTheme.borderDark,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              borderSide: BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              borderSide: BorderSide(
                color: AppTheme.errorColor,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd.w,
              vertical: AppTheme.spacingMd.h,
            ),
            hintStyle: TextStyle(
              color: theme.brightness == Brightness.light
                  ? const Color(0xFF64748B)
                  : const Color(0xFF94A3B8),
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }
}

class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    required this.items,
    super.key,
    this.label,
    this.hint,
    this.value,
    this.onChanged,
    this.validator,
  });
  final String? label;
  final String? hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacingXs.h),
        ],
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<T>(
            initialValue: value,
            items: items,

            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,

              fillColor: theme.brightness == Brightness.light
                  ? const Color(0xFFF1F5F9)
                  : const Color(0xFF1E293B),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
                borderSide: BorderSide(
                  color: theme.brightness == Brightness.light
                      ? AppTheme.borderLight
                      : AppTheme.borderDark,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
                borderSide: BorderSide(
                  color: theme.brightness == Brightness.light
                      ? AppTheme.borderLight
                      : AppTheme.borderDark,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
                borderSide: BorderSide(
                  color: AppTheme.primaryColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
                borderSide: BorderSide(
                  color: AppTheme.errorColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd.w,
                vertical: AppTheme.spacingMd.h,
              ),
              hintStyle: TextStyle(
                color: theme.brightness == Brightness.light
                    ? const Color(0xFF64748B)
                    : const Color(0xFF94A3B8),
                fontFamily: 'Inter',
              ),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: theme.brightness == Brightness.light
                  ? AppTheme.textMutedLight
                  : AppTheme.textMutedDark,
            ),
          ),
        ),
      ],
    );
  }
}

class AppDateField extends StatelessWidget {
  const AppDateField({
    super.key,
    this.label,
    this.hint,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.validator,
  });
  final String? label;
  final String? hint;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onChanged;
  final String? Function(DateTime?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacingXs.h),
        ],
        TextFormField(
          controller: controller,
          readOnly: true,
          validator: (value) {
            if (validator != null) {
              return validator!(null);
            }
            return null;
          },
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: initialDate ?? DateTime.now(),
              firstDate: firstDate ?? DateTime(1900),
              lastDate: lastDate ?? DateTime.now(),
            );
            if (date != null) {
              controller.text = '${date.day}/${date.month}/${date.year}';
              onChanged?.call(date);
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: const Icon(Icons.calendar_today),
            filled: true,
            fillColor: theme.brightness == Brightness.light
                ? const Color(0xFFF1F5F9)
                : const Color(0xFF1E293B),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              borderSide: BorderSide(
                color: theme.brightness == Brightness.light
                    ? AppTheme.borderLight
                    : AppTheme.borderDark,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              borderSide: BorderSide(
                color: theme.brightness == Brightness.light
                    ? AppTheme.borderLight
                    : AppTheme.borderDark,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              borderSide: BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd.w,
              vertical: AppTheme.spacingMd.h,
            ),
            hintStyle: TextStyle(
              color: theme.brightness == Brightness.light
                  ? const Color(0xFF64748B)
                  : const Color(0xFF94A3B8),
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }
}

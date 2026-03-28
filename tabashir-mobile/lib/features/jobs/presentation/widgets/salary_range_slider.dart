import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class SalaryRangeSlider extends StatefulWidget {
  const SalaryRangeSlider({
    required this.min,
    required this.max,
    required this.minValue,
    required this.maxValue,
    required this.onMinChanged,
    required this.onMaxChanged,
    super.key,
  });
  final int min;
  final int max;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onMinChanged;
  final ValueChanged<int> onMaxChanged;

  @override
  State<SalaryRangeSlider> createState() => _SalaryRangeSliderState();
}

class _SalaryRangeSliderState extends State<SalaryRangeSlider> {
  late int _minValue;
  late int _maxValue;

  @override
  void initState() {
    super.initState();
    _minValue = widget.minValue;
    _maxValue = widget.maxValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Min: AED ${(_minValue / 1000).round()}k',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Max: AED ${(_maxValue / 1000).round()}k',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: AppTheme.spacingMd.h),
        RangeSlider(
          values: RangeValues(_minValue.toDouble(), _maxValue.toDouble()),
          min: widget.min.toDouble(),
          max: widget.max.toDouble(),
          divisions: 50,
          activeColor: AppTheme.primaryColor,
          inactiveColor: theme.colorScheme.outline.withOpacity(0.2),
          labels: RangeLabels(
            'AED ${(_minValue / 1000).round()}k',
            'AED ${(_maxValue / 1000).round()}k',
          ),
          onChanged: (values) {
            setState(() {
              _minValue = values.start.round();
              _maxValue = values.end.round();
            });
            widget.onMinChanged(_minValue);
            widget.onMaxChanged(_maxValue);
          },
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppTheme.spacingSm.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          ),
          child: Text(
            'Selected range: AED ${(_minValue / 1000).round()}k - AED ${(_maxValue / 1000).round()}k',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class PieChartWidget extends StatelessWidget {
  final List<PieChartSectionData> sections;
  final double? height;

  const PieChartWidget({
    super.key,
    required this.sections,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height ?? 200.h,
      child: PieChart(
        PieChartData(
          sections: sections,
          sectionsSpace: 2,
          centerSpaceRadius: 50,
          startDegreeOffset: 270,
          borderData: FlBorderData(
            show: false,
          ),
          pieTouchData: PieTouchData(
            enabled: true,
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              // Handle touch events if needed
            },
          ),
        ),
      ),
    );
  }
}

/// Helper class to create pie chart sections
class PieChartHelper {
  static List<PieChartSectionData> createSections(
    List<Map<String, dynamic>> data, {
    double radius = 50,
  }) {
    return data.map((item) {
      final String name = (item['name'] as String?) ?? '';
      final int value = (item['value'] as num?)?.toInt() ?? 0;
      final String? colorString = (item['color'] as String?);
      final Color color = colorString != null
          ? _parseColor(colorString)
          : _getDefaultColor(data.indexOf(item));

      return PieChartSectionData(
        color: color,
        value: value.toDouble(),
        title: value > 0 ? '$value' : '',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titlePositionPercentageOffset: 0.5,
      );
    }).toList();
  }

  static Color _parseColor(String colorString) {
    // Convert hex color string to Color
    try {
      final String hexString = colorString.replaceAll('#', '');
      return Color(int.parse('FF$hexString', radix: 16));
    } catch (e) {
      return Colors.grey;
    }
  }

  static Color _getDefaultColor(int index) {
    final List<Color> colors = [
      AppTheme.primaryBlue,
      AppTheme.accentGreen,
      AppTheme.warningOrange,
      Colors.red,
      Colors.purple,
      Colors.teal,
    ];
    return colors[index % colors.length];
  }
}

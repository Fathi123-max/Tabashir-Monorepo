import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class BarChartWidget extends StatelessWidget {
  final List<BarChartGroupData> groups;
  final List<String> titles;
  final double? height;
  final bool isVertical;

  const BarChartWidget({
    super.key,
    required this.groups,
    required this.titles,
    this.height,
    this.isVertical = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height ?? 200.h,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: _getMaxY() * 1.2,
          barGroups: groups,
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final int index = value.toInt();
                  if (index >= 0 && index < titles.length) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        titles[index],
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.sp,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      value.toInt().toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.sp,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          gridData: const FlGridData(
            show: false,
          ),
        ),
      ),
    );
  }

  double _getMaxY() {
    double maxY = 0;
    for (final group in groups) {
      for (final rod in group.barRods) {
        if (rod.toY > maxY) {
          maxY = rod.toY;
        }
      }
    }
    return maxY;
  }
}

/// Helper class to create bar chart data
class BarChartHelper {
  static List<BarChartGroupData> createVerticalBars(
    List<Map<String, dynamic>> data,
    String labelKey,
    String valueKey, {
    Color? color,
  }) {
    final Color barColor = color ?? AppTheme.primaryBlue;

    return List.generate(data.length, (index) {
      final item = data[index];
      final String label = item[labelKey]?.toString() ?? '';
      final dynamic rawValue = item[valueKey] ?? 0;
      final double value = (rawValue is num) ? rawValue.toDouble() : 0.0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: barColor,
            width: 20.w,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      );
    });
  }

  static List<BarChartGroupData> createHorizontalBars(
    List<Map<String, dynamic>> data,
    String labelKey,
    String valueKey, {
    Color? color,
  }) {
    final Color barColor = color ?? AppTheme.accentGreen;

    return List.generate(data.length, (index) {
      final item = data[index];
      final String label = item[labelKey]?.toString() ?? '';
      final dynamic rawValue = item[valueKey] ?? 0;
      final double value = (rawValue is num) ? rawValue.toDouble() : 0.0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value,
            color: barColor,
            width: 20.w,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ],
      );
    });
  }
}

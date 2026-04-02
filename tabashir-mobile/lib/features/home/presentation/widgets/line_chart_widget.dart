import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    required this.spots,
    required this.xTitles,
    super.key,
    this.height,
    this.lineColor,
  });
  final List<FlSpot> spots;
  final List<String> xTitles;
  final double? height;
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = lineColor ?? AppTheme.primaryBlue;

    return SizedBox(
      height: height ?? 200.h,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            rightTitles: const AxisTitles(),
            topTitles: const AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < xTitles.length) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        xTitles[index],
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
                interval: _getInterval(),
                getTitlesWidget: (value, meta) => SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          minX: 0,
          maxX: spots.isNotEmpty ? spots.last.x : 5,
          minY: 0,
          maxY: _getMaxY() * 1.2,
          lineTouchData: LineTouchData(
            touchCallback: (event, touchResponse) {
              // Handle touch events if needed
            },
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: Colors.blueAccent,
              getTooltipItems: (touchedSpots) => touchedSpots
                  .map(
                    (touchedSpot) => LineTooltipItem(
                      '${touchedSpot.y.toInt()}',
                      const TextStyle(color: Colors.white),
                    ),
                  )
                  .toList(),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: color,
              barWidth: 3,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color.withOpacity(0.3),
                    color.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getMaxY() {
    if (spots.isEmpty) return 10;
    double maxY = 0;
    for (final spot in spots) {
      if (spot.y > maxY) {
        maxY = spot.y;
      }
    }
    return maxY;
  }

  double _getInterval() {
    final maxY = _getMaxY();
    if (maxY <= 10) return 2;
    if (maxY <= 50) return 10;
    if (maxY <= 100) return 20;
    return 50;
  }
}

/// Helper class to create line chart data
class LineChartHelper {
  static List<FlSpot> createSpots(
    List<Map<String, dynamic>> data,
    String xKey,
    String yKey,
  ) => List.generate(data.length, (index) {
    final item = data[index];
    // Use index as x-coordinate to handle string values like month names
    final x = index.toDouble();
    final y = (item[yKey] as num? ?? 0).toDouble();
    return FlSpot(x, y);
  });
}

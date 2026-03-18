import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/presentation/widgets/pie_chart_widget.dart';
import 'package:tabashir/features/home/presentation/widgets/bar_chart_widget.dart';
import 'package:tabashir/features/home/presentation/widgets/line_chart_widget.dart';

class HomeAnalyticsWidget extends StatelessWidget {
  const HomeAnalyticsWidget({
    super.key,
    this.applicationStatusChart = const [],
    this.matchScoreDistribution = const [],
    this.monthlyApplications = const [],
    this.skillsDemand = const [],
  });
  final List<Map<String, dynamic>> applicationStatusChart;
  final List<Map<String, dynamic>> matchScoreDistribution;
  final List<Map<String, dynamic>> monthlyApplications;
  final List<Map<String, dynamic>> skillsDemand;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Application Status Chart
        _buildChartCard(
          context,
          'Application Status'.tr(),
          Iconsax.chart,
          _buildApplicationStatusChart(context),
        ),
        SizedBox(height: AppTheme.spacingMd.h),

        // Match Score Distribution
        _buildChartCard(
          context,
          'Match Score Distribution'.tr(),
          Iconsax.percentage_circle,
          _buildMatchScoreChart(context),
        ),
        SizedBox(height: AppTheme.spacingMd.h),

        // Monthly Applications Trend
        _buildChartCard(
          context,
          'Application Trends'.tr(),
          Iconsax.graph,
          _buildMonthlyTrendChart(context),
        ),
        SizedBox(height: AppTheme.spacingMd.h),

        // Skills Demand
        _buildChartCard(
          context,
          'Skills Demand'.tr(),
          Iconsax.code,
          _buildSkillsDemandChart(context),
        ),
      ],
    );
  }

  Widget _buildChartCard(
    BuildContext context,
    String title,
    IconData icon,
    Widget child,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(
          color: theme.dividerTheme.color ?? AppTheme.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20.sp,
                color: AppTheme.primaryBlue,
              ),
              SizedBox(width: AppTheme.spacingXs.w),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          child,
        ],
      ),
    );
  }

  Widget _buildApplicationStatusChart(BuildContext context) {
    if (applicationStatusChart.isEmpty) {
      return Center(
        child: Text(
          'No data available'.tr(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
          ),
        ),
      );
    }

    final sections = PieChartHelper.createSections(applicationStatusChart);

    return Column(
      children: [
        PieChartWidget(
          sections: sections,
          height: 150.h,
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        _buildLegend(applicationStatusChart),
      ],
    );
  }

  Widget _buildMatchScoreChart(BuildContext context) {
    if (matchScoreDistribution.isEmpty) {
      return Center(
        child: Text(
          'No data available'.tr(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
          ),
        ),
      );
    }

    final groups = BarChartHelper.createVerticalBars(
      matchScoreDistribution,
      'range',
      'count',
      color: AppTheme.accentGreen,
    );

    final titles = matchScoreDistribution
        .map((item) => item['range']?.toString() ?? '')
        .toList();

    return SizedBox(
      height: 150.h,
      child: BarChartWidget(
        groups: groups,
        titles: titles,
      ),
    );
  }

  Widget _buildMonthlyTrendChart(BuildContext context) {
    if (monthlyApplications.isEmpty) {
      return Center(
        child: Text(
          'No data available'.tr(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
          ),
        ),
      );
    }

    final spots = LineChartHelper.createSpots(
      monthlyApplications,
      'month',
      'count',
    );

    final xTitles = monthlyApplications
        .map((item) => item['month']?.toString() ?? '')
        .toList();

    return SizedBox(
      height: 150.h,
      child: LineChartWidget(
        spots: spots,
        xTitles: xTitles,
        lineColor: AppTheme.primaryBlue,
      ),
    );
  }

  Widget _buildSkillsDemandChart(BuildContext context) {
    if (skillsDemand.isEmpty) {
      return Center(
        child: Text(
          'No data available'.tr(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
          ),
        ),
      );
    }

    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: skillsDemand.length,
        itemBuilder: (context, index) {
          final skill = skillsDemand[index];
          final skillName = (skill['skill'] as String?) ?? '';
          final demand = (skill['demand'] as int?) ?? 0;

          return Container(
            width: 120.w,
            margin: EdgeInsets.only(
              right: index < skillsDemand.length - 1 ? AppTheme.spacingMd.w : 0,
            ),
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              border: Border.all(
                color: AppTheme.primaryBlue.withOpacity(0.2),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  skillName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppTheme.spacingXs.h),
                Text(
                  '$demand',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLegend(List<Map<String, dynamic>> data) => Wrap(
    spacing: AppTheme.spacingMd.w,
    runSpacing: AppTheme.spacingSm.h,
    children: data.map((item) {
      final name = (item['name'] as String?) ?? '';
      final colorString = item['color'] as String?;
      final color = colorString != null
          ? _parseColor(colorString)
          : AppTheme.primaryBlue;

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: AppTheme.spacingXs.w),
          Text(
            name,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey,
            ),
          ),
        ],
      );
    }).toList(),
  );

  Color _parseColor(String colorString) {
    try {
      final hexString = colorString.replaceAll('#', '');
      return Color(int.parse('FF$hexString', radix: 16));
    } catch (e) {
      return Colors.grey;
    }
  }
}

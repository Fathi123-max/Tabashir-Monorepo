import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';
import 'package:tabashir/features/home/presentation/widgets/home_application_stat_item_widget.dart';
import 'package:tabashir/features/home/presentation/widgets/pie_chart_widget.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class HomeApplicationStatsWidget extends StatefulWidget {
  const HomeApplicationStatsWidget({super.key});

  @override
  State<HomeApplicationStatsWidget> createState() =>
      _HomeApplicationStatsWidgetState();
}

class _HomeApplicationStatsWidgetState
    extends State<HomeApplicationStatsWidget> {
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) => Container(
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
          children: [
            // Header with toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Applications'.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showChart = !_showChart;
                    });
                  },
                  icon: Icon(
                    _showChart ? Iconsax.category : Iconsax.chart,
                    size: 20.sp,
                  ),
                  tooltip: _showChart ? 'Show List'.tr() : 'Show Chart'.tr(),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Content (Chart or List)
            if (_showChart)
              _buildChartView(context, state)
            else
              _buildListView(context, state),

            SizedBox(height: AppTheme.spacingMd.h),

            // Summary
            _buildSummary(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildChartView(BuildContext context, HomeState state) {
    final applicationData = [
      {'name': 'Pending', 'value': state.pending, 'color': '#FFA500'},
      {'name': 'In Review', 'value': state.inReview, 'color': '#0D56E1'},
      {'name': 'Interview', 'value': state.interview, 'color': '#34D399'},
      {'name': 'Offer', 'value': state.offer, 'color': '#10B981'},
      {'name': 'Rejected', 'value': state.rejected, 'color': '#EF4444'},
    ].where((item) => (item['value']! as int) > 0).toList();

    if (applicationData.isEmpty) {
      return Center(
        child: Text(
          'No applications yet'.tr(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.sp,
          ),
        ),
      );
    }

    return Column(
      children: [
        PieChartWidget(
          sections: PieChartHelper.createSections(applicationData),
          height: 150.h,
        ),
        SizedBox(height: AppTheme.spacingMd.h),
        Wrap(
          spacing: AppTheme.spacingMd.w,
          runSpacing: AppTheme.spacingSm.h,
          children: applicationData.map((item) {
            final name = (item['name'] as String?) ?? '';
            final value = (item['value'] as int?) ?? 0;
            final colorString = (item['color'] as String?) ?? '#0D56E1';
            final color = _parseColor(colorString);

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
                  '$name: $value',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildListView(BuildContext context, HomeState state) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      HomeApplicationStatItemWidget(
        value: state.inReview.toString(),
        label: 'In Review'.tr(),
      ),
      Container(
        width: 1,
        height: 32.h,
        color: AppTheme.borderLight,
      ),
      HomeApplicationStatItemWidget(
        value: state.interview.toString(),
        label: 'Interview'.tr(),
      ),
      Container(
        width: 1,
        height: 32.h,
        color: AppTheme.borderLight,
      ),
      HomeApplicationStatItemWidget(
        value: state.offer.toString(),
        label: 'Offer'.tr(),
      ),
      Container(
        width: 1,
        height: 32.h,
        color: AppTheme.borderLight,
      ),
      HomeApplicationStatItemWidget(
        value: state.rejected.toString(),
        label: 'Rejected'.tr(),
      ),
    ],
  );

  Widget _buildSummary(BuildContext context, HomeState state) {
    final total =
        state.inReview + state.interview + state.offer + state.rejected;
    if (total == 0) return const SizedBox.shrink();

    final positive = state.offer;
    final percentage = total > 0 ? ((positive / total) * 100).round() : 0;

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: AppTheme.accentGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Success Rate'.tr(),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '$percentage%',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentGreen,
            ),
          ),
        ],
      ),
    );
  }

  Color _parseColor(String colorString) {
    try {
      final hexString = colorString.replaceAll('#', '');
      return Color(int.parse('FF$hexString', radix: 16));
    } catch (e) {
      return Colors.grey;
    }
  }
}

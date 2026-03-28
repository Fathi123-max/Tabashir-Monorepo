import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';
import 'package:tabashir/features/home/presentation/widgets/home_stat_card_widget.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class HomeStatsCardsRowWidget extends StatelessWidget {
  const HomeStatsCardsRowWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          HomeStatCardWidget(
            value: state.matchedJobsList.length.toString(),
            label: 'AI Matches'.tr(),
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          HomeStatCardWidget(
            value: state.totalApplications.toString(),
            label: 'Applied Jobs'.tr(),
          ),
        ],
      ),
    ),
  );
}

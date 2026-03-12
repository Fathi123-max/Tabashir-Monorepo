import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/jobs/presentation/cubit/saved_jobs_cubit.dart';

class SavedJobsSearchBar extends StatefulWidget {
  const SavedJobsSearchBar({
    required this.searchQuery,
    super.key,
  });

  final String searchQuery;

  @override
  State<SavedJobsSearchBar> createState() => _SavedJobsSearchBarState();
}

class _SavedJobsSearchBarState extends State<SavedJobsSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(SavedJobsSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != oldWidget.searchQuery &&
        _controller.text != widget.searchQuery) {
      _controller.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd.w,
      ).copyWith(top: AppTheme.spacingSm.h, bottom: AppTheme.spacingSm.h),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: theme.inputDecorationTheme.fillColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        ),
        child: Row(
          children: [
            // Search Icon
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd.w,
              ),
              child: Icon(
                Icons.search,
                color: theme.colorScheme.onSurfaceVariant,
                size: 24.sp,
              ),
            ),

            // Input Field
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search saved jobs...',
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  hintStyle: theme.inputDecorationTheme.hintStyle,
                ),
                style: theme.textTheme.bodyLarge,
                onChanged: (query) {
                  context.read<SavedJobsCubit>().updateSearchQuery(query);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

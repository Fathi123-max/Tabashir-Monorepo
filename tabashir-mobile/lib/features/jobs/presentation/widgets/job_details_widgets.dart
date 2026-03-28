import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

// Job Header Widget
class JobDetailsHeader extends StatelessWidget {
  const JobDetailsHeader({
    required this.onBack,
    required this.onShare,
    required this.onSave,
    super.key,
  });
  final VoidCallback onBack;
  final VoidCallback onShare;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) => Container(
    height: 64.h,
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).dividerColor.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40.w,
          width: 40.w,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBack,
            tooltip: 'Back'.tr(),
            color: Theme.of(context).hintColor,
            iconSize: 24.w,
          ),
        ),
        Row(
          children: [
            Container(
              height: 40.w,
              width: 40.w,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.share),
                onPressed: onShare,
                tooltip: 'Share'.tr(),
                color: Theme.of(context).hintColor,
                iconSize: 24.w,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              height: 40.w,
              width: 40.w,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.star_border),
                onPressed: onSave,
                tooltip: 'Save'.tr(),
                color: Theme.of(context).hintColor,
                iconSize: 24.w,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// Job Title Section
class JobTitleSection extends StatelessWidget {
  const JobTitleSection({
    required this.title,
    required this.company,
    required this.location,
    required this.matchPercentage,
    required this.salary,
    super.key,
  });
  final String title;
  final String company;
  final String location;
  final String matchPercentage;
  final String salary;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize: 30.sp,
        ),
      ),
      SizedBox(height: 4.h),
      Text(
        company,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 4.h),
      Text(
        location,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).hintColor,
        ),
      ),
      SizedBox(height: 16.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppTheme.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              matchPercentage,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppTheme.successColor,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              salary,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).hintColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

// Match Alert Widget
class JobMatchAlert extends StatelessWidget {
  const JobMatchAlert({
    required this.alertText,
    super.key,
  });
  final String alertText;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppTheme.primaryColor.withOpacity(0.05),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.auto_awesome,
          color: AppTheme.primaryColor,
          size: 24.w,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              children: [
                TextSpan(
                  text: "You're a strong fit! ".tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                TextSpan(
                  text: alertText,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Company Details Widget
class CompanyDetailsWidget extends StatelessWidget {
  const CompanyDetailsWidget({
    required this.companyName,
    required this.onViewProfile,
    super.key,
  });
  final String companyName;
  final VoidCallback onViewProfile;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).dividerColor.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            height: 48.w,
            width: 48.w,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Text(
                companyName.substring(0, 2).toUpperCase(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              companyName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(
                  context,
                ).textTheme.titleLarge?.color,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// Job Tags Widget
class JobTagsWidget extends StatelessWidget {
  const JobTagsWidget({
    required this.tags,
    super.key,
  });
  final List<String> tags;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 32.h,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: tags.length,
      separatorBuilder: (context, index) => SizedBox(width: 8.w),
      itemBuilder: (context, index) {
        final tag = tags[index];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Text(
              tag,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
        );
      },
    ),
  );
}

// Expandable Section Widget
class ExpandableSection extends StatefulWidget {
  const ExpandableSection({
    required this.title,
    required this.content,
    super.key,
    this.initiallyExpanded = false,
  });
  final String title;
  final Widget content;
  final bool initiallyExpanded;

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Semantics(
        label: '${widget.title}, ${_isExpanded ? "collapsed" : "expanded"}',
        button: true,
        child: GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headlineSmall?.color,
                ),
              ),
              AnimatedRotation(
                turns: _isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  Icons.expand_more,
                  color: Theme.of(context).hintColor,
                  size: 24.w,
                ),
              ),
            ],
          ),
        ),
      ),
      if (_isExpanded) ...[
        SizedBox(height: 16.h),
        widget.content,
      ],
    ],
  );
}

// Bullet Point Widget
class BulletPointWidget extends StatelessWidget {
  const BulletPointWidget({
    required this.text,
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

// Bullet Point with Badge Widget
class BulletPointWithBadgeWidget extends StatelessWidget {
  const BulletPointWithBadgeWidget({
    required this.text,
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•',
          style: TextStyle(
            fontSize: 16.sp,
            color: Theme.of(context).hintColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Stack(
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  height: 1.5,
                ),
              ),
              Positioned(
                right: -20.w,
                top: -5.h,
                child: Container(
                  height: 24.w,
                  width: 24.w,
                  decoration: BoxDecoration(
                    color: AppTheme.warningColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: AppTheme.warningColor,
                    size: 16.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Similar Opportunities Widget
class SimilarOpportunitiesWidget extends StatelessWidget {
  const SimilarOpportunitiesWidget({
    required this.opportunities,
    super.key,
  });
  final List<Map<String, dynamic>> opportunities;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Similar Opportunities'.tr(),
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: AppTheme.spacingMd.h),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: opportunities.length,
            separatorBuilder: (context, index) =>
                SizedBox(width: AppTheme.spacingLg.w),
            itemBuilder: (context, index) {
              final job = opportunities[index];
              return Container(
                width: 280.w,
                padding: EdgeInsets.all(AppTheme.spacingMd.w),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (job['title'] ?? '').toString(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      (job['company'] ?? '').toString(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingSm.h),
                    ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingSm.w,
                          vertical: AppTheme.spacingXs.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.successColor.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppTheme.radiusFull.r),
                          ),
                          border: Border.all(
                            color: AppTheme.successColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              size: 10.sp,
                              color: AppTheme.successColor,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '${job['match'] ?? ''} ${'Match'.tr()}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppTheme.successColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: AppTheme.spacingSm.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (
                            int i = 0;
                            i < ((job['tags'] as List?)?.take(2).length ?? 0);
                            i++
                          ) ...[
                            ConstrainedBox(
                              constraints: const BoxConstraints(),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppTheme.spacingXs.w,
                                  vertical: AppTheme.spacingXs.h,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.inputDecorationTheme.fillColor,
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radiusFull.r,
                                  ),
                                ),
                                child: Text(
                                  ((job['tags'] as List?)?[i] ?? '').toString(),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ),
                            if (i <
                                ((job['tags'] as List?)?.take(2).length ?? 0) -
                                    1)
                              SizedBox(width: AppTheme.spacingXs.w),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Footer Widget
class JobDetailsFooter extends StatelessWidget {
  const JobDetailsFooter({
    required this.onApply,
    required this.onSaveForLater,
    this.showLoading = false,
    this.isApplied = false,
    this.isSaved = false,
    super.key,
  });
  final VoidCallback onApply;
  final VoidCallback onSaveForLater;
  final bool showLoading;
  final bool isApplied;
  final bool isSaved;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).dividerColor.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, -2),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Semantics(
            button: true,
            label: isApplied
                ? 'You have already applied to this job'.tr()
                : 'Apply to this job'.tr(),
            child: GestureDetector(
              onTap: (showLoading || isApplied) ? null : onApply,
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  gradient: (showLoading || isApplied)
                      ? LinearGradient(
                          colors: [Colors.grey.shade400, Colors.grey.shade500],
                        )
                      : AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: (showLoading || isApplied)
                          ? Colors.transparent
                          : AppTheme.primaryColor.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: showLoading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          isApplied ? 'Applied'.tr() : 'Apply Now'.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Semantics(
          button: true,
          label: 'Save this job for later'.tr(),
          child: GestureDetector(
            onTap: onSaveForLater,
            child: Text(
              isSaved ? 'Saved'.tr() : 'Save for Later'.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: isSaved ? AppTheme.primaryColor : AppTheme.primaryColor,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

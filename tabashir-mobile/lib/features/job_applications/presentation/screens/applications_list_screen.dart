import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplicationsListScreen extends StatelessWidget {
  const ApplicationsListScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('My Applications'.tr()),
    ),
    body: Padding(
      padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment,
              size: 64.sp,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 16.h),
            Text(
              'My Applications'.tr(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Your job applications will appear here'.tr(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

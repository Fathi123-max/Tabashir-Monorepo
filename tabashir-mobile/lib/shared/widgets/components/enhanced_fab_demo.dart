import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/shared/widgets/components/standard_fab.dart';

/// Example screen demonstrating the enhanced StandardFAB component
class EnhancedFABDemoScreen extends StatelessWidget {
  const EnhancedFABDemoScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Enhanced FAB Demo'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enhanced FAB Component',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(height: 32.h),
          const Text('Standard FAB with improved styling'),
        ],
      ),
    ),
    // Standard FAB with enhanced styling
    floatingActionButton: StandardFAB(
      icon: Icons.add,
      onPressed: () {},
      tooltip: 'Add item',
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}

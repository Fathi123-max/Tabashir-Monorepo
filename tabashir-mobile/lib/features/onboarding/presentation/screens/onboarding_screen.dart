import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/features/onboarding/models/onboarding_page_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/onboarding_content.dart';
import '../widgets/onboarding_next_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingPageModel> pages = [
    OnboardingPageModel(
      icon: 'hub'.tr(),
      title: 'I’ll find jobs that fit you — not just keywords.'.tr(),
      description:
          'Upload your CV, and I’ll match you to roles based on skills, experience, and goals.'
              .tr(),
    ),
    OnboardingPageModel(
      icon: 'auto_awesome'.tr(),
      title: 'Discover your potential with tailored opportunities.'.tr(),
      description:
          'Get suggestions based on your ambitions, not just job titles.'.tr(),
    ),
    OnboardingPageModel(
      icon: 'star'.tr(),
      title: 'Let’s shape your career journey together.'.tr(),
      description:
          'Receive curated roles aligned with your strengths and goals.'.tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: BoxDecoration(gradient: AppTheme.onboardingGradient),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() {
                  _currentPage = index;
                }),
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return OnboardingContent(
                    icon: _getMaterialIcon(page.icon),
                    title: page.title,
                    description: page.description,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  _buildPageIndicators(),
                  SizedBox(height: 20.h),
                  OnboardingNextButton(
                    label: _currentPage == pages.length - 1
                        ? 'Get Started'.tr()
                        : 'Next'.tr(),
                    onPressed: () async {
                      if (_currentPage < pages.length - 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Mark onboarding as completed
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('has_completed_onboarding', true);

                        // Navigate to login screen after onboarding completion
                        context.go('/login');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildPageIndicators() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(pages.length, (index) {
      final isActive = index == _currentPage;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        height: 8.h,
        width: isActive ? 24.w : 8.w,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0D57E1) : const Color(0xFF94A3B8),
          borderRadius: BorderRadius.circular(12.r),
        ),
      );
    }),
  );

  IconData _getMaterialIcon(String name) {
    switch (name) {
      case 'auto_awesome':
        return Icons.auto_awesome;
      case 'star':
        return Icons.star;
      case 'hub':
        return Icons.hub;
      default:
        return Icons.hub;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingIcon extends StatelessWidget {
  const OnboardingIcon({
    required this.icon,
    super.key,
    this.opacity = 0.8,
  });
  final IconData icon;
  final double opacity;

  @override
  Widget build(BuildContext context) => Icon(
    icon,
    color: const Color(0xFF0D57E1).withOpacity(opacity),
    size: 160.sp, // Matches text-9xl or 10rem
  );
}

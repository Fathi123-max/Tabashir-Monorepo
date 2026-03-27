import 'package:flutter/material.dart';

class CvRequiredBlur extends StatelessWidget {
  const CvRequiredBlur({
    required this.child,
    required this.isBlurred,
    super.key,
  });
  final Widget child;
  final bool isBlurred;

  @override
  Widget build(BuildContext context) {
    // Hiding the blur view for now as requested
    return child;
  }
}

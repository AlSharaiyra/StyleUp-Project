import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widget/gestureDetector/gesturedetector.dart';

class YesButton extends StatelessWidget {
 final VoidCallback onTap;
  const YesButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double radius = MediaQuery.of(context).size.width * 0.085;
    return WidgetGesturedetector(
      onTap: onTap,
      child: Container(
        width: radius * 2.5, // Dynamic width based on radius
        height: radius * 2.5,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorsTheme.privacycolor
        ),
        child: Icon(Icons.check, color: ColorsTheme.greyDot, size: radius * 1.7),
      ),
    );
  }
}
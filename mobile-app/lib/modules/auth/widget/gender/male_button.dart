import 'package:flutter/material.dart';

import '../../../../core/widget/gestureDetector/gesturedetector.dart';

class MaleButton extends StatelessWidget {
  const MaleButton(
      {super.key,
      required this.onTap,
      required this.backgroundColor,
      required this.iconColor});
  final VoidCallback onTap;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final double radius = MediaQuery.of(context).size.width * 0.1;
    return WidgetGesturedetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 555),
          curve: Curves.easeInOut,
          width: radius * 2, // Dynamic width based on radius
          height: radius * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: Icon(Icons.male, color: iconColor, size: radius * 1.4),
        ));
  }
}
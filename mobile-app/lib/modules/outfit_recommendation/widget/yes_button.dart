import 'package:flutter/material.dart';
import 'package:style_up/core/widget/gestureDetector/gesturedetector.dart';

import '../../../core/theme/colors.dart';

class YesButton extends StatelessWidget {
  final VoidCallback onTap;
  const YesButton({super.key,required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.57;
    final double height = MediaQuery.of(context).size.height * 0.06;
    return WidgetGesturedetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: ColorsTheme.primryButton,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            'Yes , I like this one',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
               color: ColorsTheme.white,
               fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
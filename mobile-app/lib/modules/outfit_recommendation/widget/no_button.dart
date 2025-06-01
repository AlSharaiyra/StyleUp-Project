import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/widget/gestureDetector/gesturedetector.dart';

class NoButton extends StatelessWidget {
  final VoidCallback onTap;
  const NoButton({super.key, required this.onTap});

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
            color: ColorsTheme.noButton,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: ColorsTheme.primryButton,
            )),
        child: Center(
          child: Text(
            'No , show me the next',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsTheme.primryButton, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}

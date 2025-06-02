import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/widget/gestureDetector/gesturedetector.dart';
import 'package:style_up/l10n/app_localizations.dart';

class ApplyButton extends StatelessWidget {
  final VoidCallback onTap;
  const ApplyButton({
    super.key,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height *0.04; 
    final double width = MediaQuery.of(context).size.width *0.4; 
    return WidgetGesturedetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: ColorsTheme.greyBorder),
          borderRadius: BorderRadius.circular(25),
          color: ColorsTheme.primryButton
        ),
        alignment: Alignment.center,
        child: Text(
         AppLocalizations.of(context)!.apply,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: ColorsTheme.white
              ),
        ),
      ),
    );
  }
}
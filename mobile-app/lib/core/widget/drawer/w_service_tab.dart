import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';

class WidgetServiceTabs extends StatelessWidget {
  const WidgetServiceTabs({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.textStyle,
  });

  final IconData icon;
  final String title;
  final void Function() onTap;
  final Color? iconColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor ?? ColorsTheme.privacycolor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: textStyle ??
                    Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

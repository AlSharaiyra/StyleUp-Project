import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final Widget trailing;
  final VoidCallback? onTap;

  const SettingsItem({
    super.key,
    required this.title,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.025),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.045,
                  ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:style_up/core/theme/colors.dart';

class WidgetServiceTabs extends StatelessWidget {
  const WidgetServiceTabs(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});
  final IconData icon;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      //icon
      leading: Icon(icon),
      //title
      title: Text(
        title,
      ),
      // //icon color
      iconColor: ColorsTheme.privacycolor,
      titleTextStyle:
          Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.black),
      onTap: onTap,
    );
  }
}

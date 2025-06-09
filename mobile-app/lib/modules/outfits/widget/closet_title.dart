import 'package:flutter/material.dart';
import 'package:style_up/l10n/app_localizations.dart';

class ClosetTitle extends StatelessWidget {
  const ClosetTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.my_closet,
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

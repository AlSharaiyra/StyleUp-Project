import 'package:flutter/material.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class AgePickerTitle extends StatelessWidget {
  const AgePickerTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.agePickerTitle,
      style:  Theme.of(context).textTheme.displaySmall!.copyWith(
        fontWeight: FontWeight.bold,
        ),
    );
  }
}
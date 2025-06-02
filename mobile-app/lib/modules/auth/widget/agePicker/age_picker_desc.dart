import 'package:flutter/material.dart';
import 'package:style_up/l10n/app_localizations.dart';


class AgePickerDesc extends StatelessWidget {
  const AgePickerDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.agePickerDesc,
      textAlign: TextAlign.center,
      style:  Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w300,),
    );
  }
}

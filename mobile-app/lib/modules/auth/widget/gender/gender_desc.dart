import 'package:flutter/material.dart';
import 'package:style_up/l10n/app_localizations.dart';


class GenderDesc extends StatelessWidget {
  const GenderDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.genderDesc,
      textAlign: TextAlign.center,
      style:  Theme.of(context).textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
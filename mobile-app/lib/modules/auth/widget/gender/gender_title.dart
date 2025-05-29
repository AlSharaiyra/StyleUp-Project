import 'package:flutter/material.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class GenderTitle extends StatelessWidget {
  const GenderTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final double fontsize = MediaQuery.of(context).size.width * .08;
    return Text(
      AppLocalizations.of(context)!.genderTitle,
      style:  Theme.of(context).textTheme.displaySmall!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: fontsize
      ),
    );
  }
}
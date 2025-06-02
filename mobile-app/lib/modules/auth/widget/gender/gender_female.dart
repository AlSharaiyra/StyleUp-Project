import 'package:flutter/material.dart';
import 'package:style_up/l10n/app_localizations.dart';


class GenderFemale extends StatelessWidget {
  const GenderFemale({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.femaleGender,
      style:  Theme.of(context).textTheme.headlineSmall!.copyWith(
      ),
    );
  }
}
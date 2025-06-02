import 'package:flutter/material.dart';
import 'package:style_up/l10n/app_localizations.dart';


class GenderMale extends StatelessWidget {
  const GenderMale({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.maleGender,
      style:  Theme.of(context).textTheme.headlineSmall!.copyWith(
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:style_up/l10n/app_localizations.dart';


class RegisterTitle extends StatelessWidget {
  const RegisterTitle({super.key});

  @override
  Widget build(BuildContext context) {

    return Text(
      AppLocalizations.of(context)!.registerTitle,
      style:  Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold,),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class ResetPasswordTitle extends StatelessWidget {
  const ResetPasswordTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.resetPassTitle,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

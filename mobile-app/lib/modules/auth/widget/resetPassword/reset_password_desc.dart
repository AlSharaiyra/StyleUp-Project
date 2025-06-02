import 'package:flutter/material.dart';
import 'package:style_up/l10n/app_localizations.dart';


class ResetPasswordDesc extends StatelessWidget {
  const ResetPasswordDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
                AppLocalizations.of(context)!.resetPassDesc,
      style:  Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w300,),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class RegisterPolicy extends StatelessWidget {
  const RegisterPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.acceptPolicy,
      style:  Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w200, ),
    );
  }
}

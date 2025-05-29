import 'package:flutter/material.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.loginButton,
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

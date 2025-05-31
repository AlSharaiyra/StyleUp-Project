import 'package:flutter/material.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class ForgetPasswordDesc extends StatelessWidget {
  const ForgetPasswordDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.forgetPassDesc,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.w300,
          ),
    );
  }
}

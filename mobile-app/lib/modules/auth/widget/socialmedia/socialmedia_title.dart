import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SocialMediaTitle extends StatelessWidget {
  const SocialMediaTitle({super.key});

  @override
  Widget build(BuildContext context) {


    return Text(
      AppLocalizations.of(context)!.socialSignIn,
      style:  Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold,),
    );
  }
}

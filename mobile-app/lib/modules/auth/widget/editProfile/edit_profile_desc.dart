import 'package:flutter/material.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class EditProfileDesc extends StatelessWidget {
  const EditProfileDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
                AppLocalizations.of(context)!.edit_profile_desc,
      style:  Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w300,),
    );
  }
}

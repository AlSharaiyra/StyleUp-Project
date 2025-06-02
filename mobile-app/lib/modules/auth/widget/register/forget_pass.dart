import 'package:flutter/material.dart';
import 'package:style_up/l10n/app_localizations.dart';


class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key,required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
          AppLocalizations.of(context)!.forgetPass,
        style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w300
        ),
      ),
    );
  }
}
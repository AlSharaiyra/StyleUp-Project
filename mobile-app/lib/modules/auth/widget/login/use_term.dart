import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


import '../../../../core/theme/colors.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.labelMedium,
            children: <InlineSpan>[
          TextSpan(
              text: AppLocalizations.of(context)!.note,
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  )),
          TextSpan(
              text: AppLocalizations.of(context)!.accountGoverned,
              style: Theme.of(context).textTheme.labelMedium!.copyWith()),
          TextSpan(
            text: AppLocalizations.of(context)!.privacyPolicy,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: ColorsTheme.privacycolor,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorsTheme.privacycolor,
                ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(
              text: AppLocalizations.of(context)!.and,
              style: Theme.of(context).textTheme.labelMedium!.copyWith()),
          TextSpan(
            text: AppLocalizations.of(context)!.termsAndCondition,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: ColorsTheme.privacycolor,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorsTheme.privacycolor,
                ),
            recognizer: TapGestureRecognizer()..onTap = () {},
          ),
          TextSpan(
            text: AppLocalizations.of(context)!.appPolicy,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(),
          )
        ]));
  }
}

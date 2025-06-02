import 'package:flutter/material.dart';
import 'package:style_up/modules/auth/widget/otp/otp_email.dart';
import 'package:style_up/l10n/app_localizations.dart';


class OtpDesc extends StatelessWidget {
  const OtpDesc({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            AppLocalizations.of(context)!.otpDesc,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w300,
                ),
          ),
        ),
        Text(
          AppLocalizations.of(context)!.otpEnterCodeDesc,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w300,
              ),
        ),
        OtpEmail(
          email: email,
        ),
      ],
    );
  }
}

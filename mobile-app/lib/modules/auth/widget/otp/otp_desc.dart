import 'package:flutter/material.dart';
import 'package:style_up/modules/auth/widget/otp/otp_email.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpDesc extends StatelessWidget {
  const OtpDesc({super.key});

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
        const OtpEmail(),
      ],
    );
  }
}

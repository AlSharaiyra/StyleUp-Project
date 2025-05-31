import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OtpTitle extends StatelessWidget {
  const OtpTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final double fontsize = MediaQuery.of(context).size.width * .087;
    return Text(
      AppLocalizations.of(context)!.verifyAccountTitle,
      style: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(fontWeight: FontWeight.bold, fontSize: fontsize),
    );
  }
}

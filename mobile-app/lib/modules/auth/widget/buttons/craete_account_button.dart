import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/widget/buttons/button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CraeteAccountButton extends StatelessWidget {
  const CraeteAccountButton(
      {super.key, required this.onPressed, this.isRegisterPage = false});
  final VoidCallback onPressed;
  final bool isRegisterPage;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .66;
    double height = MediaQuery.of(context).size.height * .055;

    return Button(
        onPressed: onPressed,
        height: height,
        width: width,
        backgroundColor: isRegisterPage
            ? ColorsTheme.primryButton
            : ColorsTheme.secondryButton,
        foregroundColor:
            isRegisterPage ? ColorsTheme.white : ColorsTheme.primryButton,
        child: Text(
          AppLocalizations.of(context)!.createAccountButton,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: isRegisterPage
                  ? ColorsTheme.white
                  : ColorsTheme.primryButton),
        ));
  }
}

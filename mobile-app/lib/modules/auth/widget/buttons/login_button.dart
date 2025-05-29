import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/widget/buttons/button.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class LoginButton extends StatelessWidget {
  const LoginButton(
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
            ? ColorsTheme.secondryButton
            : ColorsTheme.primryButton,
        child: Text(
          AppLocalizations.of(context)!.loginButton,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: isRegisterPage
                    ? ColorsTheme.primryButton
                    : ColorsTheme.white,
              ),
        ));
  }
}

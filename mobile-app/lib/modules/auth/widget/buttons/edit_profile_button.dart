import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/widget/buttons/button.dart';
import 'package:style_up/l10n/generated/app_localizations.dart';


class EditProfileButton extends StatelessWidget {
  const EditProfileButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .66;
    double height = MediaQuery.of(context).size.height * .055;

    return Button(
        onPressed: onPressed,
        height: height,
        width: width,
        backgroundColor: ColorsTheme.primryButton,
        child: Text(
          AppLocalizations.of(context)!.save_changes,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorsTheme.white,
              ),
        ));
  }
}

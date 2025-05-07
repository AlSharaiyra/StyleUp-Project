import 'package:flutter/material.dart';
import 'package:style_up/modules/auth/controller/auth_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WSignout extends StatelessWidget {
  const WSignout({super.key, required this.title, required this.content});
  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    Widget buttom(
        BuildContext context, String tex, void Function()? onPressed) {
      //if phone is ios
      return ElevatedButton(
          onPressed: onPressed,
          child: Text(
            tex,
            style: Theme.of(context).textTheme.headlineSmall,
          ));
    }

    ///alert dialog adaptive for uoour phone
    return AlertDialog.adaptive(
      //title
      title: title,
      content: content,
      actions: [
        //for cancel
        buttom(context, AppLocalizations.of(context)!.cancel, () {
          Navigator.pop(context);
        }),
        buttom(context,AppLocalizations.of(context)!.ok, () {
          //when ok
          AuthController auth = AuthController();
          auth.logout();
        })
      ],
    );
  }
}

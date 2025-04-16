import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DidntReciveOtp extends StatelessWidget {
  const DidntReciveOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          AppLocalizations.of(context)!.didntReceive,
          style:  Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w300,)  ,
        ),
        InkWell(
          onTap: () {
            
          },
          child: Text(
            AppLocalizations.of(context)!.resendOtp,
            style:  Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold, ),
          ),
        ),
     
      ],
    );
  }
}

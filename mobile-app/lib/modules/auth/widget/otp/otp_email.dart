import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';

class OtpEmail extends StatelessWidget {
  const OtpEmail({super.key});

  @override
  Widget build(BuildContext context) {
    const String email = "useremail@email.com";
    return Text(
      email,
      style:  Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w300,
          color: ColorsTheme.primryButton),
    );
  }
}

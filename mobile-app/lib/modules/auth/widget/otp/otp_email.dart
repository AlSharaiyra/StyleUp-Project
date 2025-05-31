import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';

class OtpEmail extends StatelessWidget {
  const OtpEmail({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Text(
      email,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w300, color: ColorsTheme.primryButton),
    );
  }
}

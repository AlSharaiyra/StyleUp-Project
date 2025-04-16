import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';
import 'package:style_up/core/widget/buttons/button.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.onPressed, required this.data});
  final VoidCallback onPressed;
  final String data;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.055;
    double width = MediaQuery.of(context).size.width * 0.5;
    return Button(
        onPressed: onPressed,
        height: height,
        width: width,
        backgroundColor: ColorsTheme.primryButton,
        child: Text(
          data,
          style:  Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: ColorsTheme.white,
          ),
        ));
  }
}

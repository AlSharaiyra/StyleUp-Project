import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.onPressed,
      required this.child,
       this.backgroundColor,
       this.foregroundColor,
      required this.height,
      this.borderColor,
      required this.width});
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width;
  final double height;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    const double radius = 25;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          maximumSize: Size(width, height),
          minimumSize: Size(width, height),
          shape: RoundedRectangleBorder(
              // Button shape

              borderRadius: BorderRadius.circular(radius), // Rounded corners
              side: BorderSide(color: borderColor ?? Colors.transparent)),
          elevation: 5, // Button elevation (shadow)
          backgroundColor: backgroundColor),
      child: Center(
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WidgetGesturedetector extends StatelessWidget {
  const WidgetGesturedetector({
    super.key,
    required this.onTap,
    required this.child
    });
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}
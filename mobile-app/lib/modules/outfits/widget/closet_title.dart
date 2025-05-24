import 'package:flutter/material.dart';

class ClosetTitle extends StatelessWidget {
  const ClosetTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'My Closet',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class CloseButtonPopup extends StatelessWidget {
  final VoidCallback onPressed;
  const CloseButtonPopup({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: onPressed,
      icon: const Icon(
        Icons.close,
        color: ColorsTheme.white,
      ),
      style: IconButton.styleFrom(
        backgroundColor: ColorsTheme.primryButton,
        shadowColor: Colors.black45,
        elevation: 6,
        shape: const CircleBorder(),
        fixedSize: const Size(40, 40),
      ),
    );
  }
}

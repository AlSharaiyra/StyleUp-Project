import 'package:flutter/material.dart';
import 'package:style_up/modules/outfit_recommendation/widget/popup.dart';

class OutfitGenerate extends StatelessWidget {
  const OutfitGenerate({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierLabel: 'Popup',
          barrierColor: Colors.black54, 
          transitionDuration: const Duration(milliseconds: 350),
          pageBuilder: (context, animation, secondaryAnimation) {
            return const Center(
              child: PopupCard(
                imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx_bmXrSNSANFEEoSjZTO9EG6j4OrZrdxaJA&s',
                text: 'Try those T-shirts',
              ),
            );
          },
          transitionBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutBack,
                ),
                child: child,
              ),
            );
          },
        );
      },
      child: const Text('click me'),
    );
  }
}

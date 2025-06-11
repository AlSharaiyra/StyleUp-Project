import 'package:flutter/material.dart';
import 'package:style_up/modules/outfit_recommendation/widget/close_button.dart';
import 'package:style_up/modules/outfit_recommendation/widget/no_button.dart';
import 'package:style_up/modules/outfit_recommendation/widget/yes_button.dart';

import '../../../core/theme/colors.dart';

class PopupCard extends StatelessWidget {
  const PopupCard(
      {super.key,
      required this.imageUrl,
      required this.text,
      required this.onYesPressed,
      required this.onNoPressed});
  final String imageUrl;
  final String text;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;
  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.height * 0.03;
    final double innerWidth = MediaQuery.of(context).size.width * 0.6;
    final double innerHeight = MediaQuery.of(context).size.height * 0.3;
    final double padding = MediaQuery.of(context).size.height * 0.037;
    return Dialog(
      insetPadding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(49)),
      backgroundColor: ColorsTheme.greyBox,
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: spacing,
              children: [
                Center(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: ColorsTheme.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: innerWidth,
                  height: innerHeight,
                  decoration: BoxDecoration(
                    color: ColorsTheme.white,
                    border: BoxBorder.all(
                      color: ColorsTheme.primryButton,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(48),
                  ),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        switchInCurve: Curves.easeInOut,
                        switchOutCurve: Curves.easeInOut,
                        transitionBuilder: (child, animation) {
                          final slideAnimation = Tween<Offset>(
                            begin: const Offset(0.0, 0.2),
                            end: Offset.zero,
                          ).animate(animation);
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: slideAnimation,
                              child: child,
                            ),
                          );
                        },
                        child: Image.network(
                          imageUrl,
                          key: ValueKey(imageUrl),
                          fit: BoxFit.contain,
                          width: constraints.maxWidth * 0.9,
                          height: constraints.maxHeight * 0.9,
                        ),
                      );
                    },
                  ),
                ),
                Column(
                  spacing: spacing * 0.6,
                  children: [
                    YesButton(onTap: onYesPressed),
                    NoButton(onTap:onNoPressed),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: CloseButtonPopup(
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

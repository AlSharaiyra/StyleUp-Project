import 'package:flutter/material.dart';
import 'package:style_up/modules/outfit_recommendation/widget/no_button.dart';
import 'package:style_up/modules/outfit_recommendation/widget/yes_button.dart';

import '../../../core/theme/colors.dart';

class PopupCard extends StatelessWidget {
  const PopupCard({super.key, required this.imageUrl, required this.text});
  final String imageUrl;
  final String text;
  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.height * 0.03;
    final double padding = MediaQuery.of(context).size.height * 0.037;
    return Dialog(
      insetPadding: EdgeInsets.all(padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: ColorsTheme.greyDot,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: spacing,
          children: [
            Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: ColorsTheme.black,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double parentWidth = constraints.maxWidth;

                // Calculate half of the parent width
                final double halfWidth = parentWidth;

                return SizedBox(
                  width: halfWidth,
                  child: AnimatedSwitcher(
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
                    ),
                  ),
                );
              },
            ),
            const Text('Summer Black T-shirt '), // TODO: return the name from the api  
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NoButton(onTap: () {
                  Navigator.of(context).pop();
                }),
                YesButton(onTap: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';

class OutfitCard extends StatelessWidget {
  const OutfitCard({super.key, required this.imageUrl, required this.text});
  final String imageUrl;
  final String text;
  @override
  Widget build(BuildContext context) {
    final double cardHeight = MediaQuery.of(context).size.height * 0.33;
    final double spacing = MediaQuery.of(context).size.height * 0.03;
    const double topLeftradius = 65.0;
    const double topRightradius = 20.0;
    const double bottomRightradius = 55.0;

    const double bottomLeftRadius = 3;
    return Container(
      height: cardHeight,
      decoration: const BoxDecoration(
        color: ColorsTheme.greyDot,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bottomLeftRadius),
          bottomRight: Radius.circular(bottomRightradius),
          topLeft: Radius.circular(topLeftradius),
          topRight: Radius.circular(topRightradius),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: spacing,
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double parentWidth = constraints.maxWidth;

              // Calculate half of the parent width
              final double halfWidth = parentWidth / 2;

              return SizedBox(
                width:halfWidth,
                child: Image.network(
                  imageUrl,
                ),
              );
            },
          ),
          Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: ColorsTheme.black,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

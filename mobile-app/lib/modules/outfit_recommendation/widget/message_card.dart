import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({super.key, required this.text, this.isSender});
  final String text;
  final bool? isSender;
  @override
  Widget build(BuildContext context) {
    final double cardWidth = (MediaQuery.of(context).size.width / 2) +
        (MediaQuery.of(context).size.width * 0.13);
    final double cardHeight = MediaQuery.of(context).size.height * 0.056;
    const double topLeftradius = 20.0;
    const double topRightradius = 20.0;
    const double bottomRightradius = 20.0;

    const double bottomLeftRadius = 3;
    return Align(
      alignment:
          isSender == true ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: cardWidth,
        constraints: BoxConstraints(
            minHeight: cardHeight), // Minimum height to ensure some space
        decoration: BoxDecoration(
          color:
              isSender == true ? ColorsTheme.primryButton : ColorsTheme.greyDot,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightradius),
            topLeft: Radius.circular(topLeftradius),
            topRight: Radius.circular(topRightradius),
          ),
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 10.0,), // Add some vertical padding for better spacing
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10), // Adding space before text
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color:
                        isSender == true ? ColorsTheme.white : ColorsTheme.black,
                        fontWeight: FontWeight.normal
                  ),
                  
              textAlign: TextAlign.start, // Align text to start (left for LTR)
              softWrap: true, // Ensure long text wraps within the container
              textDirection: TextDirection
                  .ltr, // Ensure LTR text rendering for mixed language text
            ),
          ),
        ),
      ),
    );
  }
}

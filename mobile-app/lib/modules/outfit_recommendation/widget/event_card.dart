import 'package:flutter/material.dart';
import 'package:style_up/core/theme/colors.dart';

class EventCard extends StatelessWidget {
  const EventCard(
      {super.key,
      this.backgroundColor,
      this.borderColor,
      required this.onTap,
      required this.text,
      this.isTextBold});
  final Color? backgroundColor;
  final Color? borderColor;
  final String text;
  final VoidCallback? onTap;
  final bool? isTextBold;
  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.7;
    final double cardHeight = MediaQuery.of(context).size.height * 0.05;
    const double radius = 25.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        child: Center(
            child: SizedBox(
                height: cardHeight,
                width: cardWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(radius)),
                    border: Border.all(
                      color: borderColor ?? ColorsTheme.greyBorder,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: isTextBold == true
                                ? FontWeight.bold
                                : FontWeight.w200,
                          ),
                    ),
                  ),
                ))),
      ),
    );
  }
}

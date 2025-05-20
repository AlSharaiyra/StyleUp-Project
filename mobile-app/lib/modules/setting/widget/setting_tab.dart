import 'package:flutter/material.dart';

class SettingTab extends StatelessWidget {
  const SettingTab({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
    this.textStyle,
    required this.widget,
  });

  final Widget widget;
  final String title;
  final void Function() onTap;
  final TextStyle? textStyle;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Responsive dimensions
    final horizontalPadding = screenWidth * 0.04; // e.g. 16 on 400px
    final verticalPadding = screenHeight * 0.01; // e.g. 8 on 800px
    final avatarRadius = screenWidth * 0.065; // e.g. 26 on 400px

    return Container(
      height: screenHeight * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(75),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: avatarRadius * 2.5,
                    height: avatarRadius * 2.5,
                  ),
                ),
              ),
              SizedBox(
                  width: screenWidth * 0.09), // spacing between avatar and text
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: 
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                        width:
                            screenWidth * 0.015), // controls distance to widget
                    widget,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

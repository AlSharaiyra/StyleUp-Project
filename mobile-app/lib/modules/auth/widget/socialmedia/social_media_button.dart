import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:style_up/core/widget/buttons/button.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton(
      {super.key,
      required this.onPressed,
      required this.imageUrl,
      this.isAsset = false});
  final VoidCallback onPressed;
  final String imageUrl; // Change from String to IconData
  final bool isAsset;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * .23;
    double height = MediaQuery.of(context).size.height * 0.06;

    return Button(
        onPressed: onPressed,
        height: height,
        width: width,
        child: isAsset
            ? Image.asset(
                imageUrl,
                width: width * 0.6,
                height: height * 0.6,
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                height: height * 0.6,
                width: width * 0.6,
              ));
  }
}

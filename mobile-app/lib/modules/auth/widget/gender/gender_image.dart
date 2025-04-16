import 'package:flutter/material.dart';

class GenderImage extends StatelessWidget {
  const GenderImage({
    super.key,
    required this.image
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    final double imageWidth = MediaQuery.of(context).size.width * 0.65; 
    final double imageHeight = MediaQuery.of(context).size.height * 0.35; 
    return Image.asset(
      image,
      width: imageWidth,
      height: imageHeight,
      fit: BoxFit.cover,
    );
  }
}
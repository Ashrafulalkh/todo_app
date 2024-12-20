import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgPictureWidget extends StatelessWidget {
  final String assetPath; // Path to the SVG asset
  final double? width; // Width of the SVG image
  final double? height; // Height of the SVG image

  const SvgPictureWidget({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        semanticsLabel: 'SVG Image', // Optional description for accessibility
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomHomeListItemClipper extends CustomClipper<Path> {
  Path path = Path();

  CustomHomeListItemClipper({
    required this.radius,
    required this.clipHeight,
    required this.clipWidth,
  });
  final double radius;
  final double clipHeight;
  final double clipWidth;

  @override
  Path getClip(Size size) {
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - clipHeight - radius);
    path.arcToPoint(
      Offset(size.width - radius, size.height - clipHeight),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(size.width - clipWidth + radius, size.height - clipHeight);
    path.arcToPoint(
      Offset(size.width - clipWidth, size.height - clipHeight + radius),
      radius: Radius.circular(radius),
      clockwise: false,
    );
    path.lineTo(size.width - clipWidth, size.height - radius);
    path.arcToPoint(
      Offset(size.width - clipWidth - radius, size.height),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

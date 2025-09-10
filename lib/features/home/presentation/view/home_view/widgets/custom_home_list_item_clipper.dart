
import 'package:flutter/material.dart';

class CustomHomeListItemClipper extends CustomClipper<Path> {
  Path path = Path();

  CustomHomeListItemClipper({
    required this.isArabic,
    required this.radius,
    required this.clipHeight,
    required this.clipWidth,
    this.innerRadius = 16,
  });
  final double radius;
  final double clipHeight;
  final double clipWidth;
  final double innerRadius;
  final bool isArabic;

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
      radius: Radius.circular(innerRadius),
      clockwise: false,
    );
    path.lineTo(size.width - clipWidth, size.height - radius);
    path.arcToPoint(
      Offset(size.width - clipWidth - radius, size.height),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(0, size.height);
    if (isArabic) {
      final Matrix4 matrix4 = Matrix4.identity()
        ..scale(-1.0, 1.0)
        ..translate(-size.width.toDouble(), 0.0);

      return path.transform(matrix4.storage);
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomHomeListItemClipper oldClipper) {
    return oldClipper.isArabic != isArabic;
  }
}

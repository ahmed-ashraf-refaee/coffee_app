import 'package:flutter/material.dart';

class ContainerClipper extends CustomClipper<Path> {
  var path = Path();
  @override
  Path getClip(Size size) {
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.50, size.height);
    path.cubicTo(
      size.width * 0.93,
      size.height + 8,
      size.width * 0.53,
      size.height * 0.8 - 8,
      size.width * 0.9,
      size.height * 0.79,
    );
    path.conicTo(
      size.width,
      size.height * 0.77 + 2,
      size.width,
      size.height * 0.6,
      3,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

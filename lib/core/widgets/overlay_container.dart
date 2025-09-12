import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class OverlayContainer extends StatelessWidget {
  const OverlayContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
    this.width,
    this.height,
  });
  final Widget child;
  final EdgeInsets padding;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: width ?? context.width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.surface,
        ),
        child: child,
      ),
    );
  }
}

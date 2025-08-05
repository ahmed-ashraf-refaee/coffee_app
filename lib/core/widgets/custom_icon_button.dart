import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    this.width = 48,
    this.hight = 48,
    this.backgroundColor = ColorPalette.raisinBlack,
    this.foregroundColor = ColorPalette.cadetGray,
    this.borderRadius,
    this.borderColor,
    required this.child,
  });

  final VoidCallback onPressed;
  final double width;
  final double hight;
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fixedSize: Size(width, hight),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(16),
          side: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
        ),
      ),
      icon: child,
    );
  }
}

import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.hight,
    required this.backgroundColor,
    required this.foregroundColor,
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        fixedSize: Size(width, hight),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          side: BorderSide(color: borderColor ?? Colors.transparent, width: 2),
        ),
      ),
      child: child,
    );
  }
}

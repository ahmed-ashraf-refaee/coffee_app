import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.width,
    this.height = 32,
    required this.onPressed,
    required this.child,
    this.contentPadding,
    this.backgroundColor,
    this.shrink = 1,
  });
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsets? contentPadding;
  final VoidCallback onPressed;
  final int shrink;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      shrink: shrink,
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor ?? context.colors.primary,
        ),
        width: context.width,
        child: Padding(
          padding: contentPadding ?? const EdgeInsets.all(20.0),
          child: SizedBox(height: height, child: child),
        ),
      ),
    );
  }
}

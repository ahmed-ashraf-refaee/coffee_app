import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.width,
    this.height,
    required this.onPressed,
    required this.child,
    this.contentPadding,
  });
  final double? width;
  final double? height;
  final EdgeInsets? contentPadding;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      shrink: 1,
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.primary,
        ),
        width: context.width,
        height: height,
        child: Padding(
          padding: contentPadding ?? EdgeInsets.all(20.0),
          child: child,
        ),
      ),
    );
  }
}

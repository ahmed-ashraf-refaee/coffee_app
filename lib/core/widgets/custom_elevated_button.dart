import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.width,
    this.height = 64,
    required this.onPressed,
    required this.child,
    this.contentPadding,
    this.backgroundColor,
    this.shrink = 1,
    this.wrapContent = false,
  });

  final double? width;
  final double? height;
  final Color? backgroundColor;
  final EdgeInsets? contentPadding;
  final VoidCallback onPressed;
  final int shrink;
  final Widget child;
  final bool wrapContent;

  @override
  Widget build(BuildContext context) {
    final double? effectiveWidth = wrapContent
        ? null
        : (width ?? double.infinity);

    return IntrinsicWidth(
      child: PrettierTap(
        shrink: shrink,
        onPressed: onPressed,
        child: Container(
          width: effectiveWidth,
          height: height,
          alignment: Alignment.center,
          padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor ?? context.colors.primary,
          ),
          child: child,
        ),
      ),
    );
  }
}

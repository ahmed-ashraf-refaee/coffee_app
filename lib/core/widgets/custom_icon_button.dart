import 'package:coffee_app/core/widgets/prettier_tap.dart';

import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    this.width = 48,
    this.hight = 48,
    this.backgroundColor,
    this.borderRadius,
    this.localeAware = true,
    this.padding = 12,
    required this.child,
  });

  final VoidCallback onPressed;
  final double width;
  final double hight;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final bool localeAware;
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      onPressed: onPressed,
      child: Container(
        width: width,
        height: hight,
        decoration: BoxDecoration(
          color: backgroundColor ?? context.colors.secondary,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child: Transform.scale(
          scaleX: localeAware
              ? context.isArabic
                    ? -1
                    : 1
              : 1,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: FittedBox(child: child),
          ),
        ),
      ),
    );
  }
}

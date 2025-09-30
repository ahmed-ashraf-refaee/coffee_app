import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
    this.isLoading = false,
    this.disabled = false,
  });

  final double? width;
  final double height;
  final Color? backgroundColor;
  final EdgeInsets? contentPadding;
  final VoidCallback onPressed;
  final int shrink;
  final bool isLoading;
  final Widget child;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final Widget effectiveChild = isLoading
        ? SpinKitThreeBounce(
            color: context.colors.onPrimary,
            size: height * 0.5,
          )
        : (disabled && child is Text
              ? DefaultTextStyle.merge(
                  style: TextStyle(color: context.colors.onSecondary),
                  child: child,
                )
              : DefaultTextStyle.merge(
                  style: TextStyle(color: context.colors.onPrimary),
                  child: child,
                ));

    final Widget body = Container(
      width: width ?? context.width,
      height: height,
      alignment: Alignment.center,
      padding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: disabled
            ? context.colors.secondary
            : (backgroundColor ?? context.colors.primary),
      ),
      child: effectiveChild,
    );

    return disabled
        ? body
        : PrettierTap(shrink: shrink, onPressed: onPressed, child: body);
  }
}

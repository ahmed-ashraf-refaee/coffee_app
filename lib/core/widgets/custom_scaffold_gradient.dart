import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorPalette.eerieBlack, ColorPalette.raisinBlack],
          end: Alignment.topRight,
          begin: Alignment.centerLeft,
          stops: const [0.5, 1.0],
        ),
      ),
      child: child,
    );
  }
}

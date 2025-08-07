import 'package:flutter/material.dart';

import '../utils/color_palette.dart';

class CustomGradientContainer extends StatelessWidget {
  const CustomGradientContainer({
    super.key,
    this.child,
    this.bottomNavigationBar,
  });

  final Widget? child;
  final Widget? bottomNavigationBar;

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorPalette.eerieBlack, ColorPalette.raisinBlack],
          end: Alignment.topRight,
          begin: Alignment.centerLeft,
          stops: const [0.6, 1.0],
        ),
      ),
      child: child,
    );
  }
}

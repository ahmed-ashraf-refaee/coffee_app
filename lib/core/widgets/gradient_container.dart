import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colors.surface, context.colors.secondary],
          end: Alignment.topRight,
          begin: Alignment.centerLeft,
          stops: const [0.6, 1.0],
        ),
      ),
      child: child,
    );
  }
}

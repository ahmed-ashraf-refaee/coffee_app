import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height,
      color: context.colors.surface,
      child: child,
    );
  }
}

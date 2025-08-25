import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class ProfileGroupContainer extends StatelessWidget {
  const ProfileGroupContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}

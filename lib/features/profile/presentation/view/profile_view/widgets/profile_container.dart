import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key, required this.child});
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

import 'package:flutter/material.dart';
import 'package:coffee_app/main.dart';

class ProfileDivider extends StatelessWidget {
  const ProfileDivider({super.key, this.intend = 16});
  final double intend;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.colors.onSecondary.withValues(alpha: 0.85),
      indent: intend,
      endIndent: intend,
      thickness: 1,
    );
  }
}

import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class ProfileTileDivider extends StatelessWidget {
  const ProfileTileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.colors.onSecondary.withValues(alpha: 85),
      indent: 16,
      endIndent: 16,
      thickness: 1,
    );
  }
}

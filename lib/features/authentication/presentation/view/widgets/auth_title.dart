import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/main.dart';

import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.bold32),
        Text(
          subtitle,
          style: TextStyles.bold14.copyWith(
            color: context.colors.onSecondary.withAlpha(153),
          ),
        ),
      ],
    );
  }
}

import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/main.dart';

import 'package:flutter/material.dart';

class TitleSubtitle extends StatelessWidget {
  const TitleSubtitle({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.bold28),
        Text(
          subtitle,
          style: TextStyles.bold14.copyWith(
            color: context.colors.onSecondary.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

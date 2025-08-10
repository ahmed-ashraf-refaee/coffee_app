import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/text_styles.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    this.prefixIcon,
    required this.title,
    required this.suffixWidget,
    this.padding,
  });
  final String? prefixIcon;
  final Widget suffixWidget;
  final String title;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (prefixIcon != null)
            Image.asset(
              prefixIcon!,
              height: 24,
              color: context.colors.onSecondary,
            ),
          if (prefixIcon != null) SizedBox(width: 26),
          Text(
            title,
            style: TextStyles.semi16.copyWith(
              color: context.colors.onSecondary,
            ),
          ),
          Spacer(),
          suffixWidget,
        ],
      ),
    );
  }
}

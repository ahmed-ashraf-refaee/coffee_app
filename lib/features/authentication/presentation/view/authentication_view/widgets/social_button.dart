import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  final String imageAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      shrink: 3,
      onPressed: onPressed,
      child: Column(
        spacing: 8,
        children: [
          Image.asset(
            imageAsset,
            width: 42,
            height: 42,
            color: context.colors.onSecondary,
          ),

          Text(
            title,
            style: TextStyles.bold14.copyWith(
              color: context.colors.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

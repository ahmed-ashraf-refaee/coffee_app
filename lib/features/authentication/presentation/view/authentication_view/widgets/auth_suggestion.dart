import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class AuthSuggestion extends StatelessWidget {
  const AuthSuggestion({
    super.key,
    required this.toggleAuthMode,
    required this.suggestionText,
    required this.actionText,
  });
  final void Function({String? email}) toggleAuthMode;
  final String suggestionText;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: context.isArabic
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            suggestionText,
            style: TextStyles.bold16.copyWith(
              color: context.colors.onSecondary,
            ),
          ),
          PrettierTap(
            shrink: 2,
            onPressed: () {
              toggleAuthMode();
            },
            child: Text(
              actionText,
              style: TextStyles.bold20.copyWith(color: context.colors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

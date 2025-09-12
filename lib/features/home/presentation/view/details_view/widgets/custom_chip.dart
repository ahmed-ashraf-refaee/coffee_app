import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.contentPadding = const EdgeInsets.all(12),
  });
  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final EdgeInsets contentPadding;
  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      wrapContent: true,
      shrink: 3,
      height: 48,
      contentPadding: contentPadding,
      backgroundColor: selected
          ? context.colors.primary
          : context.colors.secondary,
      onPressed: onSelected,
      child: Text(
        label,
        style: TextStyles.regular15.copyWith(
          color: selected
              ? context.colors.onPrimary
              : context.colors.onSecondary,
        ),
      ),
    );
  }
}

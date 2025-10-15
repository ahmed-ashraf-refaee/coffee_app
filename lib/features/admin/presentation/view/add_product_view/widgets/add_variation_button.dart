import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/prettier_tap.dart';

class AddVariantButton extends StatelessWidget {
  final bool show;
  final VoidCallback onAdd;

  const AddVariantButton({super.key, required this.show, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    return PrettierTap(
      onPressed: onAdd,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          S.current.addAnotherVariant,
          style: TextStyles.medium16.copyWith(
            color: context.colors.primary,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

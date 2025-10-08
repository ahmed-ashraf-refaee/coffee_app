import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/prettier_tap.dart';

class AddVariantButton extends StatelessWidget {
  final bool show;
  final VoidCallback onAdd;

  const AddVariantButton({super.key, required this.show, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    if (!show) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.centerRight,
      child: PrettierTap(
        onPressed: onAdd,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Ionicons.add_circle_outline),
            const SizedBox(width: 6),
            Text(
              "Add another variant",
              style: TextStyles.medium16.copyWith(
                color: context.colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

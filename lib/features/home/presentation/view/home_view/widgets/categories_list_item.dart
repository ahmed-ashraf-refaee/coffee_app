import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/text_styles.dart';

class CategoriesListItem extends StatelessWidget {
  const CategoriesListItem({
    super.key,
    required this.category,
    required this.selected,
    required this.onSelected,
  });
  final String category;
  final bool selected;
  final VoidCallback onSelected;
  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      onPressed: onSelected,
      child: SizedBox(
        height: 32,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  category,
                  style: TextStyles.regular16.copyWith(
                    color: selected
                        ? context.colors.onSurface
                        : context.colors.onSecondary.withAlpha(153),
                  ),
                ),
              ),
            ),

            if (selected)
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: selected ? 1 : 0,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

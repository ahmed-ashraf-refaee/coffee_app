import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/text_styles.dart';

class CategoriesListItem extends StatefulWidget {
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
  State<CategoriesListItem> createState() => _CategoriesListItemState();
}

class _CategoriesListItemState extends State<CategoriesListItem> {
  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      onPressed: widget.onSelected,
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
                  widget.category,
                  style: TextStyles.regular16.copyWith(
                    color: widget.selected
                        ? context.colors.onSurface
                        : context.colors.onSecondary.withAlpha(153),
                  ),
                ),
              ),
            ),

            if (widget.selected)
              AnimatedOpacity(
                duration: Duration(milliseconds: 300),
                opacity: widget.selected ? 1 : 0,
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

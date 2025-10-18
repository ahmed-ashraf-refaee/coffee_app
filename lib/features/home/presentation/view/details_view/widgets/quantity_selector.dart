import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.value,
    required this.onChanged,
    required this.contentPadding,
    this.backgroundColor,
    this.maxValue = 99,
    this.minValue = 0,
    this.isLoading = false,
    this.padding,
    this.vertical = false,
  });

  final int value;
  final EdgeInsets contentPadding;
  final ValueChanged<int> onChanged;
  final Color? backgroundColor;
  final int maxValue;
  final int minValue;
  final bool isLoading;
  final double? padding;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final fadedMinus = value <= minValue;
    final fadedPlus = value >= maxValue;

    final removeButton = CustomIconButton(
      width: 32,
      hight: vertical ? 28 : 32,
      padding: vertical ? 2 : 4,
      backgroundColor: Colors.transparent,
      onPressed: fadedMinus ? null : () => onChanged(value - 1),
      child: Icon(
        Ionicons.remove,
        color: context.colors.onSurface.withValues(alpha: fadedMinus ? 0.3 : 1),
      ),
    );

    final addButton = CustomIconButton(
      width: 32,
      hight: 32,
      padding: 4,
      backgroundColor: Colors.transparent,
      onPressed: fadedPlus ? null : () => onChanged(value + 1),
      child: Icon(
        Ionicons.add,
        color: context.colors.onSurface.withValues(alpha: fadedPlus ? 0.3 : 1),
      ),
    );

    final valueWidget = Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding ?? 4,
        vertical: padding ?? 4,
      ),
      child: SizedBox(
        width: 24,
        height: 24,
        child: isLoading
            ? CircularProgressIndicator(
                padding: const EdgeInsets.all(4),
                color: context.colors.primary,
                strokeWidth: 1.6,
              )
            : Text(
                "$value",
                style: TextStyles.medium16.copyWith(
                  color: context.colors.primary,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );

    return Container(
      padding: contentPadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? context.colors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: vertical
          ? Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [addButton, valueWidget, removeButton],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [removeButton, valueWidget, addButton],
            ),
    );
  }
}

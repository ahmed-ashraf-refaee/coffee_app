import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

enum StatusType { money, count, percentage }

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.title,
    required this.icon,
    required this.change,
    required this.value,
    required this.type,
  });

  final String title;
  final IconData icon;
  final double change;
  final num value;
  final StatusType type;

  @override
  Widget build(BuildContext context) {
    final isPositive = change >= 0;

    return PrettierTap(
      shrink: 2,
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: context.isArabic
              ? TextDirection.rtl
              : TextDirection.ltr,
          children: [
            CustomIconButton(
              onPressed: () {},
              backgroundColor: context.colors.surface,
              width: 48,
              hight: 42,
              child: Icon(icon, color: context.colors.primary),
            ),
            Text(
              title,
              style: TextStyles.bold16.copyWith(
                color: context.colors.onSecondary,
              ),
            ),
            Text(value.formatValue(type), style: TextStyles.bold20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPositive
                      ? Ionicons.arrow_up_outline
                      : Ionicons.arrow_down_outline,
                  color: isPositive ? Colors.green : Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  change.formatChange(),
                  style: TextStyles.regular15.copyWith(
                    color: isPositive ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension ValueFormatExtension on num {
  String formatValue(StatusType type) {
    switch (type) {
      case StatusType.money:
        if (this >= 1000000) {
          return '\$${(this / 1000000).toStringAsFixed(this % 1000000 == 0 ? 0 : 1)}M';
        } else if (this >= 1000) {
          return '\$${(this / 1000).toStringAsFixed(this % 1000 == 0 ? 0 : 1)}K';
        } else {
          return '\$${toStringAsFixed(this == roundToDouble() ? 0 : 1)}';
        }

      case StatusType.count:
        if (this >= 1000000) {
          return '${(this / 1000000).toStringAsFixed(this % 1000000 == 0 ? 0 : 1)}M';
        } else if (this >= 1000) {
          return '${(this / 1000).toStringAsFixed(this % 1000 == 0 ? 0 : 1)}K';
        } else {
          return toStringAsFixed(this == roundToDouble() ? 0 : 1);
        }

      case StatusType.percentage:
        return '${toStringAsFixed(1)}%';
    }
  }
}

extension DoubleFormatExtension on double {
  String formatChange() {
    final absValue = ((this * 100).roundToDouble() / 100).abs();
    return '${absValue.toStringAsFixed(1)}%';
  }
}

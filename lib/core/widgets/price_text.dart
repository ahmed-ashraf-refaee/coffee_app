import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double? discount;
  final double? fontSize;
  final double? oldPriceSize;
  final double? discountSize;
  final int? quantity;

  const PriceText({
    super.key,
    required this.price,
    this.discount,
    this.fontSize,
    this.oldPriceSize,
    this.discountSize,
    this.quantity,
  });

  double get discountedPrice =>
      discount != null && discount! > 0 && discount! < 100
      ? price * (1 - discount! / 100)
      : price;

  bool get hasDiscount => discount != null && discount! > 0;

  double get totalPrice => discountedPrice * (quantity ?? 1);

  @override
  Widget build(BuildContext context) {
    Widget buildOldPriceWithDiscount() {
      final originalTotal = price * (quantity ?? 1);

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Text(
                originalTotal.toStringAsFixed(2),
                style: TextStyles.regular12.copyWith(
                  fontSize: oldPriceSize,
                  color: context.colors.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Transform.rotate(
                      angle: -0.15,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: constraints.maxHeight * 0.1,
                          width: constraints.maxWidth,
                          color: context.colors.onSecondary.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: context.colors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(
                  Ionicons.ticket_outline,
                  size: discountSize ?? 14,
                  color: context.colors.primary,
                ),
                const SizedBox(width: 2),
                Text(
                  "-${discount!.toStringAsFixed(0)}%",
                  style: TextStyles.regular12.copyWith(
                    fontSize: discountSize != null
                        ? discountSize! * 0.9
                        : 12, // scales with icon size
                    color: context.colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget buildNewPriceAnimated() {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: price, end: totalPrice),
        duration: const Duration(milliseconds: 400),
        builder: (context, value, _) {
          return RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value.toStringAsFixed(2),
                  style: TextStyles.regular22.copyWith(
                    fontSize: fontSize,
                    color: context.colors.primary,
                  ),
                ),
                TextSpan(
                  text: " ${S.current.egp}",
                  style: TextStyles.regular15.copyWith(
                    fontSize: fontSize != null ? fontSize! * 0.6 : null,
                    color: context.colors.primary,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (hasDiscount) buildOldPriceWithDiscount(),
        buildNewPriceAnimated(),
      ],
    );
  }
}

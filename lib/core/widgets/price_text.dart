import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double? discount;
  final double? fontSize;
  final double? oldPriceSize;
  final int? quantity;

  const PriceText({
    super.key,
    required this.price,
    this.discount,
    this.fontSize,
    this.oldPriceSize,
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
    Widget buildOldPrice() {
      final originalTotal = price * (quantity ?? 1);
      return Stack(
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
                      color: context.colors.onSecondary.withValues(alpha: 0.6),
                    ),
                  ),
                );
              },
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
      children: [if (hasDiscount) buildOldPrice(), buildNewPriceAnimated()],
    );
  }
}

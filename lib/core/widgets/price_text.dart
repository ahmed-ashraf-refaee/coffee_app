import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final double price;
  final double? discount;
  final double? fontSize;
  final double? oldPriceSize;

  const PriceText({
    super.key,
    required this.price,
    this.discount,
    this.fontSize,
    this.oldPriceSize,
  });

  double get discountedPrice =>
      discount != null && discount! > 0 && discount! < 100
      ? price * (1 - discount! / 100)
      : price;

  bool get hasDiscount => discount != null && discount! > 0;

  @override
  Widget build(BuildContext context) {
    final currency = S.of(context).egp;

    Widget buildOldPrice() {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Text(
            price.toStringAsFixed(2),
            style: TextStyles.regular12.copyWith(
              fontSize: oldPriceSize,
              color: context.colors.onSurface.withValues(alpha: 0.6),
            ),
          ),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Transform.rotate(
                  angle: -0.15, // slight tilt
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

    Widget buildNewPrice() {
      return RichText(
        textHeightBehavior: const TextHeightBehavior(
          applyHeightToFirstAscent: false,
          applyHeightToLastDescent: false,
        ),
        text: TextSpan(
          children: [
            TextSpan(
              text: discountedPrice.toStringAsFixed(2),
              style: TextStyles.regular22.copyWith(
                fontSize: fontSize,
                color: context.colors.primary,
              ),
            ),
            TextSpan(
              text: " $currency",
              style: TextStyles.regular15.copyWith(
                fontSize: fontSize != null ? fontSize! * 0.6 : null,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [if (hasDiscount) buildOldPrice(), buildNewPrice()],
    );
  }
}

import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../add_product_view.dart';

class VariantsSection extends StatelessWidget {
  final List<Variant> variants;
  final Function(int) removeVariant;
  final String? Function(String?, String) requiredValidator;
  final String? Function(String?, String, {bool required}) doubleValidator;

  const VariantsSection({
    super.key,
    required this.variants,
    required this.removeVariant,
    required this.requiredValidator,
    required this.doubleValidator,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.variantsTitle,
          style: TextStyles.bold20.copyWith(color: context.colors.onSurface),
        ),
        ...variants.asMap().entries.map((entry) {
          final index = entry.key;
          final variant = entry.value;
          return Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: context.colors.secondary,
            ),
            child: Column(
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${l10n.variantLabel} ${index + 1}',
                      style: TextStyles.medium16.copyWith(
                        color: context.colors.onSecondary,
                      ),
                    ),
                    if (variants.length > 1)
                      PrettierTap(
                        onPressed: () => removeVariant(index),
                        child: Text(
                          S.current.remove,
                          style: TextStyles.bold14.copyWith(
                            color: context.colors.primary,
                          ),
                        ),
                      ),
                  ],
                ),
                TextFormField(
                  controller: variant.sizeController,
                  decoration: InputDecoration(
                    hintText: l10n.variantSizeHint,
                    prefixIcon: const Icon(Ionicons.resize_outline),
                    fillColor: context.colors.surface,
                  ),
                  validator: (v) => requiredValidator(v, l10n.variantSizeLabel),
                ),
                TextFormField(
                  controller: variant.priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: l10n.variantPriceHint,
                    prefixIcon: const Icon(Ionicons.cash_outline),
                    fillColor: context.colors.surface,
                  ),
                  validator: (v) => doubleValidator(v, l10n.variantPriceLabel),
                ),
                TextFormField(
                  controller: variant.quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: l10n.variantQuantityHint,
                    prefixIcon: const Icon(Ionicons.cube_outline),
                    fillColor: context.colors.surface,
                  ),
                  validator: (v) =>
                      doubleValidator(v, l10n.variantQuantityLabel),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

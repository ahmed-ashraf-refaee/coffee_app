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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Variants",
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
              color: context.colors.surface,
              border: Border.all(
                color: context.colors.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              spacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Variant ${index + 1}", style: TextStyles.medium16),
                    if (variants.length > 1)
                      CustomIconButton(
                        onPressed: () => removeVariant(index),
                        backgroundColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        child: Icon(
                          Ionicons.trash_outline,
                          color: context.colors.primary,
                        ),
                      ),
                  ],
                ),
                TextFormField(
                  controller: variant.sizeController,
                  decoration: const InputDecoration(
                    hintText: "Size (e.g. Small, Medium)",
                    prefixIcon: Icon(Ionicons.resize_outline),
                  ),
                  validator: (v) => requiredValidator(v, "Size"),
                ),
                TextFormField(
                  controller: variant.priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Price (e.g. 9.99)",
                    prefixIcon: Icon(Ionicons.cash_outline),
                  ),
                  validator: (v) => doubleValidator(v, "Price"),
                ),
                TextFormField(
                  controller: variant.quantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Quantity (in stock)",
                    prefixIcon: Icon(Ionicons.cube_outline),
                  ),
                  validator: (v) => doubleValidator(v, "Quantity"),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

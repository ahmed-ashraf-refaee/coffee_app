import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_rounded_images.dart';
import 'edit_product_overlay.dart';

class StockProductCard extends StatelessWidget {
  const StockProductCard({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomRoundedImage(
                      imageUrl: product.imageUrl,
                      aspectRatio: 1,
                      width: 64,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyles.bold16.copyWith(
                              color: context.colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.category?.name ?? 'Unknown',
                            style: TextStyles.regular12.copyWith(
                              color: context.colors.onSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  CustomElevatedButton(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    onPressed: () {
                      editProductOverlay(
                        context,
                        variants: product.productVariants,
                        onSave: () {},
                      );
                    },
                    height: 34,
                    width: 86,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Edit", style: TextStyles.bold14),
                        Icon(
                          Ionicons.create_outline,
                          color: context.colors.onPrimary,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(color: context.colors.onSecondary.withValues(alpha: 0.2)),
          const SizedBox(height: 12),

          /// ========== VARIANT LIST ==========
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Variants",
                style: TextStyles.bold14.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(height: 8),

              // Display all product variants
              ...product.productVariants.map((variant) {
                final ProductStatus variantStatus = variant.quantity == 0
                    ? ProductStatus.out
                    : (variant.quantity < 20
                          ? ProductStatus.low
                          : ProductStatus.inStock);

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.colors.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _buildInfoColumn(context, 'Size', variant.size),
                          const SizedBox(width: 32),
                          _buildInfoColumn(
                            context,
                            'Stock',
                            '${variant.quantity}',
                          ),
                          const SizedBox(width: 32),
                          _buildInfoColumn(
                            context,
                            'Price',
                            '\$${variant.price.toStringAsFixed(2)}',
                          ),
                        ],
                      ),

                      /// Right side: variant status
                      _buildStatusBadge(context, variantStatus),
                    ],
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.regular12.copyWith(
            color: context.colors.onSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyles.bold16.copyWith(color: context.colors.onSurface),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context, ProductStatus status) {
    Color color;
    String text;

    switch (status) {
      case ProductStatus.inStock:
        color = Colors.green;
        text = 'In Stock';
        break;
      case ProductStatus.low:
        color = Colors.orange;
        text = 'Low';
        break;
      case ProductStatus.out:
        color = context.colors.primary;
        text = 'Out';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(text, style: TextStyles.bold14.copyWith(color: color)),
    );
  }
}

enum ProductStatus { inStock, low, out }

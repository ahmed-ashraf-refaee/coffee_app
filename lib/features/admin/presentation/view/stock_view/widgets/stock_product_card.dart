import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/text_styles.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              const SizedBox(width: 12),
              PrettierTap(
                onPressed: () {
                  editProductOverlay(
                    context,
                    variants: product.productVariants,
                    onSave: () {},
                  );
                },
                child: Text(
                  "Edit",
                  style: TextStyles.bold14.copyWith(
                    color: context.colors.primary,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(color: context.colors.onSecondary.withValues(alpha: 0.6)),
          const SizedBox(height: 12),

          /// ========== VARIANT LIST ==========
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.current.variantsTitle,
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
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildInfoColumn(
                                context,
                                'Size',
                                variant.size,
                              ),
                            ),
                            Expanded(
                              child: _buildInfoColumn(
                                context,
                                'Stock',
                                '${variant.quantity}',
                              ),
                            ),
                            Expanded(
                              child: _buildInfoColumn(
                                context,
                                'Price',
                                '${variant.price.toStringAsFixed(2)}${S.current.egp}',
                              ),
                            ),
                          ],
                        ),
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
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.regular12.copyWith(
            color: context.colors.onSecondary,
          ),
          overflow: TextOverflow.ellipsis,
        ),

        Text(
          value,
          style: TextStyles.bold14.copyWith(color: context.colors.onSurface),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStatusBadge(BuildContext context, ProductStatus status) {
    Color color;

    switch (status) {
      case ProductStatus.inStock:
        color = ColorPalette.darkGreen;

        break;
      case ProductStatus.low:
        color = ColorPalette.orangeCrayola;

        break;
      case ProductStatus.out:
        color = ColorPalette.errorLuxurious;

        break;
    }

    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

enum ProductStatus { inStock, low, out }

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
    final l10n = S.current;

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
                            product.category?.name ?? l10n.unknownCategory,
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
                  l10n.editButton,
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

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.variantsTitle,
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
                                l10n.variantSizeLabel,
                                variant.size,
                              ),
                            ),
                            Expanded(
                              child: _buildInfoColumn(
                                context,
                                l10n.variantStockLabel,
                                '${variant.quantity}',
                              ),
                            ),
                            Expanded(
                              child: _buildInfoColumn(
                                context,
                                l10n.variantPriceLabel,
                                '${variant.price.toStringAsFixed(2)}${l10n.egp}',
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Right side: variant status
                      _buildStatusBadge(context, variantStatus, l10n),
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

  Widget _buildStatusBadge(BuildContext context, ProductStatus status, S l10n) {
    Color color;
    String label;

    switch (status) {
      case ProductStatus.inStock:
        color = ColorPalette.darkGreen;
        label = l10n.statusInStock;
        break;
      case ProductStatus.low:
        color = ColorPalette.orangeCrayola;
        label = l10n.statusLow;
        break;
      case ProductStatus.out:
        color = ColorPalette.errorLuxurious;
        label = l10n.statusOut;
        break;
    }

    return Tooltip(
      message: label,
      child: Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}

enum ProductStatus { inStock, low, out }

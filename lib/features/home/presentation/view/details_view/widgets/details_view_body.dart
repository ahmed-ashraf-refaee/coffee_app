import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/animated_icon_switch.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/core/widgets/price_text.dart';
import 'package:coffee_app/core/widgets/product_rating.dart';
import 'package:coffee_app/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/details_view/widgets/custom_chip.dart';
import 'package:coffee_app/features/home/presentation/view/details_view/widgets/quantity_selector.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/model/product_model.dart';
import '../../../../../wishlist/presentation/manager/wishlist/wishlist_cubit.dart';

class DetailsViewBody extends StatefulWidget {
  final ProductModel product;
  final String tag;

  const DetailsViewBody({super.key, required this.product, required this.tag});

  @override
  State<DetailsViewBody> createState() => _DetailsViewBodyState();
}

class _DetailsViewBodyState extends State<DetailsViewBody> {
  int selectedIndex = 0;
  int quantity = 1;

  void onSelected(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomAppBar(
          leading: CustomIconButton(
            padding: 8,
            onPressed: GoRouter.of(context).pop,
            child: Icon(
              Ionicons.chevron_back,
              color: context.colors.onSecondary,
            ),
          ),
          trailing: BlocBuilder<WishlistCubit, WishlistState>(
            buildWhen: (previous, current) {
              if (previous is WishlistSuccess && current is WishlistSuccess) {
                final wasInPrevious = previous.products.any(
                  (p) => p.id == product.id,
                );
                final isInCurrent = current.products.any(
                  (p) => p.id == product.id,
                );
                return wasInPrevious != isInCurrent;
              }
              return true;
            },
            builder: (context, state) {
              final isFavorite = context.read<WishlistCubit>().isFavorite(
                productId: product.id,
              );
              return AnimatedIconSwitch(
                onChanged: (value) {
                  context.read<WishlistCubit>().toggleFavorite(
                    product: product,
                  );
                },
                initialState: isFavorite,
                isFilled: true,
                children: [
                  Icon(Ionicons.heart_outline, color: context.colors.primary),
                  Icon(Ionicons.heart, color: context.colors.primary),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            PrettierTap(
              shrink: 1,
              onPressed: () => UiHelpers.showOverlay(
                context: context,
                child: ProductImageOverlay(widget: widget),
              ),
              child: Hero(
                tag: widget.tag,
                child: CustomRoundedImage(
                  imageUrl: product.imageUrl,
                  aspectRatio: 6 / 4,
                  width: context.width,
                ),
              ),
            ),

            // 🔹 Discount Overlay (slightly bigger version)
            if (product.discount > 0)
              Positioned(
                top: 8,
                left: context.isArabic ? null : 8,
                right: context.isArabic ? 8 : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.flip(
                      flipX: !context.isArabic,
                      child: Icon(
                        Ionicons.pricetag,
                        size: 64, // slightly larger
                        color: context.colors.primary,
                      ),
                    ),
                    Transform.rotate(
                      angle: context.isArabic ? -0.785398 : 0.785398,
                      child: Text(
                        '${product.discount.toStringAsFixed(0)}%',
                        style: TextStyles.bold16.copyWith(
                          color: context.colors.onPrimary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(product.name, style: TextStyles.medium32),
        const SizedBox(height: 8),
        ProductRating(
          rating: product.rating,
          numberOfRatings: product.numberOfRatings,
          size: 16,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.description,
                    style: TextStyles.regular16.copyWith(
                      height: 1.2,
                      color: context.colors.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _buildVariantsChips(context),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PriceText(
              price: product.productVariants[selectedIndex].price,
              discount: product.discount,
              fontSize: 32,
              oldPriceSize: 14,
              quantity: quantity,
            ),
            Container(
              decoration: BoxDecoration(
                color: context.colors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 56,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(S.current.quantity, style: TextStyles.semi16),
                  ),
                  Container(
                    height: 24,
                    width: 1,
                    color: context.colors.onSecondary.withValues(alpha: 0.6),
                  ),
                  QuantitySelector(
                    value: quantity,
                    maxValue: product.productVariants[selectedIndex].quantity,
                    minValue: 1,
                    onChanged: (value) {
                      setState(() {
                        quantity = value;
                      });
                    },
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading:
                  state is CartAddItemLoading && state.productId == product.id,
              onPressed: () {
                BlocProvider.of<CartCubit>(context).addItem(
                  productVariantId: product.productVariants[selectedIndex].id,
                  quantity: quantity,
                  productId: product.id,
                );
              },
              child: Text(S.current.addToCart, style: TextStyles.medium20),
            );
          },
        ),
      ],
    );
  }

  Row _buildVariantsChips(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      spacing: 16,
      children: List.generate(3, (index) {
        if (index < widget.product.productVariants.length) {
          return Expanded(
            child: CustomChip(
              label: widget.product.productVariants[index].size,
              onSelected: () {
                onSelected(index);
                quantity = 1;
              },
              selected: selectedIndex == index,
            ),
          );
        }
        return Expanded(child: SizedBox(width: context.width, height: 56));
      }),
    );
  }
}

class ProductImageOverlay extends StatelessWidget {
  const ProductImageOverlay({super.key, required this.widget});

  final DetailsViewBody widget;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.tag,
      child: CachedNetworkImage(
        imageUrl: widget.product.imageUrl,
        fit: BoxFit.contain,
        errorWidget: (context, url, error) =>
            const Icon(Ionicons.warning_outline, size: 30),
      ),
    );
  }
}

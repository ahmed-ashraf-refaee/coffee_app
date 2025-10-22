import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/price_text.dart';
import 'package:coffee_app/core/widgets/product_rating.dart';
import 'package:coffee_app/features/cart/data/model/cart_item_model.dart';
import 'package:coffee_app/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_rounded_images.dart';
import '../../../../../core/widgets/prettier_tap.dart';
import '../../../../home/presentation/view/details_view/widgets/quantity_selector.dart';

class CartListItem extends StatelessWidget {
  final CartItemModel cartItem;

  const CartListItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Slidable(
        key: ValueKey(cartItem.id),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              context.read<CartCubit>().removeItem(cartItemId: cartItem.id);
            },
          ),
          children: [
            Builder(
              builder: (slidableContext) {
                return CustomSlidableAction(
                  backgroundColor: context.colors.primary,
                  foregroundColor: context.colors.onPrimary,
                  onPressed: (_) async {
                    final slidable = Slidable.of(slidableContext);
                    slidable?.dismiss(
                      ResizeRequest(const Duration(milliseconds: 300), () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          BlocProvider.of<CartCubit>(
                            slidableContext,
                          ).removeItem(cartItemId: cartItem.id);
                        });
                      }),
                    );
                  },
                  child: CustomIconButton(
                    hight: 56,
                    width: 56,
                    onPressed: () async {
                      final slidable = Slidable.of(slidableContext);
                      slidable?.dismiss(
                        ResizeRequest(const Duration(milliseconds: 300), () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            BlocProvider.of<CartCubit>(
                              context,
                            ).removeItem(cartItemId: cartItem.id);
                          });
                        }),
                      );
                    },
                    child: Icon(
                      Ionicons.bag_remove_outline,
                      color: context.colors.primary,
                    ),
                  ),
                );
              },
            ),
          ],
        ),

        child: PrettierTap(
          shrink: 1,
          onPressed: () {
            GoRouter.of(context).push(
              AppRouter.kDetailsView,
              extra: {
                "product": cartItem.product,
                "tag": "${cartItem.product.id}_cartItem",
              },
            );
          },
          child: Container(
            height: 158,
            width: context.width,
            color: context.colors.secondary,
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomRoundedImage(
                  imageUrl: cartItem.product.imageUrl,
                  aspectRatio: 3 / 4,
                  width: 124,
                  borderRadius: BorderRadius.circular(8),
                ),

                // Right side content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Product title
                      Text(
                        cartItem.product.name,
                        style: TextStyles.regular20,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),

                      // Row for info + quantity
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: ProductRating(
                                      rating: cartItem.product.rating,
                                      numberOfRatings:
                                          cartItem.product.numberOfRatings,
                                    ),
                                  ),
                                  Text(
                                    cartItem
                                        .product
                                        .productVariants[cartItem
                                            .selectedVariantIndex]
                                        .size,
                                    style: TextStyles.regular15.copyWith(
                                      color: context.colors.onSecondary
                                          .withValues(alpha: 0.6),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  PriceText(
                                    price: cartItem
                                        .product
                                        .productVariants[cartItem
                                            .selectedVariantIndex]
                                        .price,
                                    discount: cartItem.product.discount,
                                    quantity: cartItem.quantity,
                                  ),
                                ],
                              ),
                            ),

                            BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                return QuantitySelector(
                                  vertical: true,
                                  padding: 0,
                                  isLoading:
                                      state is CartItemLoading &&
                                      state.id == cartItem.id,
                                  backgroundColor: context.colors.surface,
                                  value: cartItem.quantity,
                                  maxValue: cartItem
                                      .product
                                      .productVariants[cartItem
                                          .selectedVariantIndex]
                                      .quantity,
                                  minValue: 1,
                                  onChanged: (v) {
                                    context.read<CartCubit>().updateQuantity(
                                      cartItemId: cartItem.id,
                                      newQuantity: v,
                                    );
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

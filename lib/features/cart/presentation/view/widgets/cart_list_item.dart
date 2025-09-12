import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/cart/data/model/cart_item_model.dart';
import 'package:coffee_app/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const DrawerMotion(),
          children: [
            CustomSlidableAction(
              backgroundColor: context.colors.primary,
              foregroundColor: context.colors.onPrimary,
              onPressed: (BuildContext context) {},
              child: CustomIconButton(
                hight: 56,
                width: 56,
                onPressed: () {
                  BlocProvider.of<CartCubit>(
                    context,
                  ).removeItem(productVariantId: cartItem.productVariantId);
                  Slidable.of(context)?.close();
                },
                child: Icon(
                  Ionicons.bag_remove_outline,
                  color: context.colors.primary,
                ),
              ),
            ),
          ],
        ),
        child: PrettierTap(
          shrink: 1,
          onPressed: () {},
          child: Container(
            height: 132,
            width: context.width,
            color: context.colors.secondary,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRoundedImage(
                    imageUrl: cartItem.product!.imageUrl,
                    aspectRatio: 3 / 4,
                    width: 124,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          cartItem.product!.name,
                          style: TextStyles.regular20,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          cartItem.productVariant!.size,
                          style: TextStyles.regular12.copyWith(
                            color: context.colors.onSecondary.withAlpha(153),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "\$",
                                    style: TextStyles.regular15.copyWith(
                                      color: context.colors.primary,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        (cartItem.productVariant!.price *
                                                cartItem.quantity)
                                            .toStringAsFixed(2),
                                    style: TextStyles.regular22.copyWith(
                                      color: context.colors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            QuantitySelector(
                              backgroundColor: context.colors.surface,
                              value: cartItem.quantity,
                              maxValue: cartItem.productVariant!.quantity,
                              minValue: 1,
                              onChanged: (v) {
                                context.read<CartCubit>().updateQuantity(
                                  productVariantId: cartItem.productVariantId,
                                  newQuantity: v,
                                );
                              },
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

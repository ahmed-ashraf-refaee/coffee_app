import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/wishlist/presentation/manager/wishlist/wishlist_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_rounded_images.dart';
import '../../../../../core/widgets/prettier_tap.dart';

class WishlistListItem extends StatelessWidget {
  const WishlistListItem({super.key, required this.product});
  final ProductModel product;
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
                  Slidable.of(context)?.close();
                  context.read<WishlistCubit>().toggleFavorite(
                    product: product,
                  );
                },
                child: Icon(
                  Ionicons.heart_dislike_outline,
                  color: context.colors.primary,
                ),
              ),
            ),
          ],
        ),

        child: PrettierTap(
          shrink: 1,
          onPressed: () {
            GoRouter.of(context).push(
              AppRouter.kDetailsView,
              extra: {"product": product, "tag": "${product.id}_wishlist"},
            );
          },
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
                  Hero(
                    tag: "${product.id}_wishlist",
                    child: CustomRoundedImage(
                      imageUrl: product.imageUrl,
                      aspectRatio: 3 / 4,
                      width: 124,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          product.name,
                          style: TextStyles.regular20,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          product.productVariants[0].size,
                          style: TextStyles.regular12.copyWith(
                            color: context.colors.onSecondary.withAlpha(153),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),

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
                                text: product.productVariants[0].price
                                    .toStringAsFixed(2),
                                style: TextStyles.regular22.copyWith(
                                  color: context.colors.primary,
                                ),
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
      ),
    );
  }
}

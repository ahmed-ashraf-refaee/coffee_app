import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/price_text.dart';
import 'package:coffee_app/core/widgets/product_rating.dart';
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
  final ProductModel product;

  const WishlistListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Slidable(
        key: ValueKey(product.id),
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              context.read<WishlistCubit>().toggleFavorite(product: product);
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
                          BlocProvider.of<WishlistCubit>(
                            slidableContext,
                          ).toggleFavorite(product: product);
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
                            BlocProvider.of<WishlistCubit>(
                              context,
                            ).toggleFavorite(product: product);
                          });
                        }),
                      );
                    },
                    child: Icon(
                      Ionicons.heart_dislike_outline,
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
              extra: {"product": product, "tag": "${product.id}_wishlist"},
            );
          },
          child: Container(
            height: 158,
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
                        const SizedBox(height: 2),
                        ProductRating(
                          rating: product.rating,
                          numberOfRatings: product.numberOfRatings,
                        ),
                        Text(
                          product.productVariants[0].size,
                          style: TextStyles.regular15.copyWith(
                            color: context.colors.onSecondary.withValues(
                              alpha: 0.6,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        PriceText(
                          price: product.productVariants[0].price,
                          discount: product.discount,
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

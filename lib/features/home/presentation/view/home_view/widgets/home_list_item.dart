import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/core/widgets/price_text.dart';
import 'package:coffee_app/core/widgets/product_rating.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/custom_home_list_item_clipper.dart';
import 'package:coffee_app/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class HomeListItem extends StatelessWidget {
  final ProductModel product;

  const HomeListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    void onPressed(Map<String, dynamic> extra) {
      GoRouter.of(context).push(AppRouter.kDetailsView, extra: extra);
    }

    final bool isSoldOut = product.productVariants.every(
      (v) => v.quantity == 0,
    );

    return PrettierTap(
      shrink: 1,
      onPressed: () {
        onPressed({"product": product, "tag": "${product.id}_normalProduct"});
      },
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomHomeListItemClipper(
              isArabic: context.isArabic,
              radius: 12,
              clipHeight: 48,
              clipWidth: 48,
            ),
            child: Container(
              height: context.height,
              width: context.width,
              decoration: BoxDecoration(
                color: context.colors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: "${product.id}_normalProduct",
                          child: CustomRoundedImage(
                            imageUrl: product.imageUrl,
                            aspectRatio: 4 / 3,
                            width: context.width,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        if (isSoldOut)
                          AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.colors.surface.withValues(
                                  alpha: context.read<ThemeCubit>().isDark
                                      ? 0.85
                                      : 0.6,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                S.current.soldOut,
                                style: TextStyles.bold20.copyWith(
                                  color: context.colors.error,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.name,
                      style: TextStyles.bold16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    ProductRating(
                      showFiveStars: false,
                      rating: product.rating,
                      numberOfRatings: product.numberOfRatings,
                    ),
                    const Spacer(),
                    PriceText(
                      price: product.productVariants[0].price,
                      discount: product.discount,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: context.isArabic
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            child: CustomIconButton(
              padding: 8,
              hight: 36,
              width: 36,
              backgroundColor: context.colors.primary,
              onPressed: () {
                onPressed({
                  "product": product,
                  "tag": "${product.id}_normalProduct",
                });
              },
              child: Icon(
                Ionicons.chevron_forward,
                color: context.colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

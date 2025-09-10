import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/core/widgets/translatable_text.dart';
import 'package:coffee_app/features/home/data/model/product_model.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/custom_home_list_item_clipper.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class HomeListItem extends StatelessWidget {
  final ProductModel product;

  const HomeListItem({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    void onPressed() {
      GoRouter.of(context).push(AppRouter.kDetailsView, extra: product);
    }

    return PrettierTap(
      shrink: 1,
      onPressed: onPressed,
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 6,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: product.id,
                      child: CustomRoundedImage(
                        imageUrl: product.imageUrl,
                        aspectRatio: 4 / 3,
                        width: context.width,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    TranslatableText(
                      product.name,
                      style: TextStyles.bold16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TranslatableText(
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
              onPressed: onPressed,
              child: Icon(Ionicons.add, color: context.colors.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/home/presentation/view/details_view/widgets/custom_chip.dart';
import 'package:coffee_app/features/home/presentation/view/details_view/widgets/quantity_selector.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/model/product_model.dart';

class DetailsViewBody extends StatefulWidget {
  final ProductModel product;

  const DetailsViewBody({super.key, required this.product});

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
          trailing: CustomIconButton(
            padding: 8,
            onPressed: () {},
            child: Icon(Ionicons.heart_outline, color: context.colors.primary),
          ),
        ),
        const SizedBox(height: 16),
        PrettierTap(
          shrink: 1,
          onPressed: () => UiHelpers.showOverlay(
            context: context,
            child: Hero(
              tag: widget.product.id,
              child: CachedNetworkImage(
                imageUrl: widget.product.imageUrl,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) =>
                    const Icon(Ionicons.warning_outline, size: 30),
              ),
            ),
          ),
          child: Hero(
            tag: widget.product.id,
            child: CustomRoundedImage(
              imageUrl: widget.product.imageUrl,
              aspectRatio: 6 / 4,
              width: context.width,
            ),
          ),
        ),
        const SizedBox(height: 24),

        Text(widget.product.name, style: TextStyles.medium32),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    widget.product.description,
                    style: TextStyles.regular16.copyWith(
                      height: 1.2,
                      color: context.colors.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          spacing: 16,
          children: List.generate(widget.product.productVariants.length, (
            index,
          ) {
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
          }),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("quantity", style: TextStyles.semi16),

                QuantitySelector(
                  value: quantity,
                  maxValue:
                      widget.product.productVariants[selectedIndex].quantity,
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
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "\$",
                    style: TextStyles.regular20.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                  TextSpan(
                    text:
                        (widget.product.productVariants[selectedIndex].price *
                                quantity)
                            .toStringAsFixed(2),
                    style: TextStyles.regular36.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        CustomElevatedButton(
          onPressed: () {},
          child: Text(
            "Add to Cart",
            style: TextStyles.medium20.copyWith(
              color: context.colors.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

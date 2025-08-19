import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/features/home/presentation/view/widgets/custom_chip.dart';
import 'package:coffee_app/features/home/presentation/view/widgets/quantity_selector.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class DetailsViewBody extends StatefulWidget {
  const DetailsViewBody({super.key, required this.tag});
  final String tag;

  @override
  State<DetailsViewBody> createState() => _DetailsViewBodyState();
}

class _DetailsViewBodyState extends State<DetailsViewBody> {
  int selectedIndex = 0;
  int quantity = 99;
  void onSelected(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // stores the index of the selected chip

    final List<String> options = ["180ml", "240ml", "320ml"];
    return Padding(
      padding: const EdgeInsets.all(16.0),

      child: Column(
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
              child: Icon(
                Ionicons.heart_outline,
                color: context.colors.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Hero(
            tag: widget.tag,
            child: CustomRoundedImage(
              imageUrl:
                  "https://img.buzzfeed.com/video-api-prod/assets/6ccf991f920e4effa2e4272e52d31f1e/BFV17568_Frozen_Irish_Coffee-Thumb.jpg",
              aspectRatio: 6 / 4,
              width: context.width,
            ),
          ),
          const SizedBox(height: 24),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: "Cappucino Latte\n", style: TextStyles.medium32),
                WidgetSpan(child: SizedBox(height: 48)),
                TextSpan(text: "Description\n", style: TextStyles.semi16),
                TextSpan(
                  text:
                      "A cappuccino is an espresso-based coffee drink that originated in Austria with later development taking place in Italy, and is prepared with steamed milk foam",
                  style: TextStyles.regular16.copyWith(
                    height: 1.2,
                    color: context.colors.onSecondary,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            spacing: 16,
            children: List.generate(options.length, (index) {
              return Expanded(
                child: CustomChip(
                  label: options[index],
                  onSelected: () => onSelected(index),
                  selected: selectedIndex == index,
                ),
              );
            }),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("quantity", style: TextStyles.semi16),

                  QuantitySelector(
                    value: quantity,
                    onChanged: (value) {
                      setState(() {
                        quantity = value;
                      });
                    },
                    contentPadding: EdgeInsets.all(8),
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
                      text: "20",
                      style: TextStyles.regular36.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          CustomElevatedButton(
            onPressed: () {},
            child: const Text("Add to Cart", style: TextStyles.medium20),
          ),
        ],
      ),
    );
  }
}

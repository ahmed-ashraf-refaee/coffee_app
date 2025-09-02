import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_rounded_images.dart';
import '../../../../../core/widgets/prettier_tap.dart';

class WishlistListItem extends StatefulWidget {
  const WishlistListItem({super.key});

  @override
  State<WishlistListItem> createState() => _WishlistListItemState();
}

class _WishlistListItemState extends State<WishlistListItem> {
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
                },
                child: Icon(
                  Ionicons.heart_dislike_outline,
                  color: context.colors.primary,
                ),
              ),
            ),
          ],
        ),
        key: const Key("hi"),

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
                    imageUrl:
                        "https://img.buzzfeed.com/video-api-prod/assets/6ccf991f920e4effa2e4272e52d31f1e/BFV17568_Frozen_Irish_Coffee-Thumb.jpg",
                    aspectRatio: 3 / 4,
                    width: 124,
                    borderRadius: BorderRadius.circular(8),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Cappucino Latte",
                          style: TextStyles.regular20,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "180ml",
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
                                text: "20",
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

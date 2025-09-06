import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/custom_home_list_item_clipper.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingHomeListItem extends StatelessWidget {
  const LoadingHomeListItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: UiHelpers.customShimmer(context),
      enabled: true,
      child: PrettierTap(
        shrink: 1,
        onPressed: () {},
        child: Stack(
          children: [
            ClipPath(
              clipper: CustomHomeListItemClipper(
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
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Skeleton.shade(
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.colors.secondary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),

                      const Text(
                        "COFFEE",
                        style: TextStyles.bold16,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "100ML",
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
                              text: "0.99",
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
            Positioned(
              bottom: 0,
              right: 0,
              child: Skeleton.shade(
                child: CustomIconButton(
                  padding: 8,
                  hight: 36,
                  width: 36,
                  backgroundColor: context.colors.secondary,
                  onPressed: () {},
                  child: const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

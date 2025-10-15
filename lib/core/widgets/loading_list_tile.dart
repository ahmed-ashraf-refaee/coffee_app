import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../helper/ui_helpers.dart';
import '../utils/text_styles.dart';

class LoadingListTile extends StatelessWidget {
  const LoadingListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Skeletonizer(
        effect: UiHelpers.customShimmer(context),
        enabled: true,
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
                Skeleton.leaf(
                  child: Container(
                    width: 124,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colors.onSecondary,
                    ),
                  ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Skeleton.leaf(
                        child: Text(
                          "Cappucino Latte",
                          style: TextStyles.regular20,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Skeleton.leaf(
                        child: Text(
                          "180ml",
                          style: TextStyles.regular12.copyWith(
                            color: context.colors.onSecondary.withValues(
                              alpha: 0.6,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),

                      Skeleton.leaf(
                        child: RichText(
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

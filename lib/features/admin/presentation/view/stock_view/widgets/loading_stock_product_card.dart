import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../core/helper/ui_helpers.dart';

class LoadingStockProductCard extends StatelessWidget {
  const LoadingStockProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: UiHelpers.customShimmer(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      /// Product image placeholder
                      Skeleton.shade(
                        child: Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                            color: context.colors.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      /// Product name + category
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Skeleton.shade(
                              child: Container(
                                height: 16,
                                width: 120,
                                color: context.colors.surface,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Skeleton.shade(
                              child: Container(
                                height: 12,
                                width: 80,
                                color: context.colors.surface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Skeleton.shade(
                  child: Container(
                    height: 34,
                    width: 86,
                    decoration: BoxDecoration(
                      color: context.colors.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Divider(color: context.colors.onSecondary.withValues(alpha: 0.2)),
            const SizedBox(height: 12),

            /// "Variants" Title
            Skeleton.shade(
              child: Container(
                height: 14,
                width: 70,
                color: context.colors.surface,
              ),
            ),
            const SizedBox(height: 8),

            /// Variants placeholders (3 items)
            Column(
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.colors.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Left: info columns
                      Row(
                        children: [
                          _buildSkeletonInfo(context),
                          const SizedBox(width: 32),
                          _buildSkeletonInfo(context),
                          const SizedBox(width: 32),
                          _buildSkeletonInfo(context),
                        ],
                      ),

                      /// Right: status badge
                      Skeleton.shade(
                        child: Container(
                          height: 24,
                          width: 60,
                          decoration: BoxDecoration(
                            color: context.colors.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// A reusable info column skeleton
  Widget _buildSkeletonInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeleton.shade(
          child: Container(
            height: 10,
            width: 40,
            color: context.colors.secondary,
          ),
        ),
        const SizedBox(height: 4),
        Skeleton.shade(
          child: Container(
            height: 14,
            width: 50,
            color: context.colors.secondary,
          ),
        ),
      ],
    );
  }
}

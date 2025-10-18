import 'package:coffee_app/core/helper/ui_helpers.dart';

import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReviewListLoading extends StatelessWidget {
  const ReviewListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: UiHelpers.customShimmer(context),
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          children: List.generate(3, (_) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.colors.secondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colors.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          Container(
                            height: 14,
                            width: 120,
                            color: context.colors.surface,
                          ),
                          Row(
                            spacing: 6,
                            children: List.generate(
                              5,
                              (_) => Icon(
                                Icons.star,
                                size: 16,
                                color: context.colors.surface,
                              ),
                            ),
                          ),
                          Container(
                            height: 12,
                            width: double.infinity,
                            color: context.colors.surface,
                          ),
                          Container(
                            height: 12,
                            width: double.infinity,
                            color: context.colors.surface,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

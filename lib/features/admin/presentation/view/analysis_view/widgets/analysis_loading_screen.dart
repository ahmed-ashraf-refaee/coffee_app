import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AnalysisLoadingScreen extends StatelessWidget {
  const AnalysisLoadingScreen({super.key});

  Widget shimmerBox(
    BuildContext context, {
    double? h,
    double? w,
    Color? color,
    double radius = 8,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: h,
        width: w,
        color: color ?? context.colors.onSecondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: UiHelpers.customShimmer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
            children: List.generate(4, (_) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colors.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 8,
                  children: [
                    shimmerBox(
                      context,
                      h: 42,
                      w: 48,
                      color: context.colors.surface,
                    ),
                    shimmerBox(context, h: 14, w: 80),
                    shimmerBox(context, h: 20, w: 60),
                    shimmerBox(context, h: 14, w: 40),
                  ],
                ),
              );
            }),
          ),
          PrettierTap(
            shrink: 1,
            onPressed: () {},
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                color: context.colors.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  shimmerBox(context, h: 16, w: 100),
                  Expanded(
                    child: shimmerBox(
                      context,
                      h: double.infinity,
                      w: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../helper/ui_helpers.dart';

class CustomRoundedImage extends StatelessWidget {
  const CustomRoundedImage({
    super.key,
    required this.imageUrl,
    required this.aspectRatio,
    required this.width,
    this.borderRadius,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.isAsset = false,
  });
  final String imageUrl;
  final double aspectRatio;
  final double width;
  final bool isAsset;

  final BorderRadius? borderRadius;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().isDark;

    final Color color = isDark
        ? Color.lerp(context.colors.surface, context.colors.onSurface, 0.05)!
        : Color.lerp(context.colors.surface, context.colors.onSurface, 0.1)!;
    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: Container(
            color: color,

            child: isAsset
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(imageUrl),
                  )
                : CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,

                    placeholder: (context, url) => Skeletonizer(
                      effect: UiHelpers.customShimmer(context),
                      child: Skeleton.shade(
                        child: Container(
                          width: width,
                          height: width / aspectRatio,
                          color: context.colors.secondary,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: color,
                      child: const Icon(Ionicons.warning_outline, size: 30),
                    ),
                    errorListener: (_) {
                      // Do nothing to silence HttpException logs
                    },
                  ),
          ),
        ),
      ),
    );
  }
}

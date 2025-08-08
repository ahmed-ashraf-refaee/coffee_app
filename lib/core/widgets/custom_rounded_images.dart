import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/color_palette.dart';

class CustomRoundedImage extends StatelessWidget {
  const CustomRoundedImage({
    super.key,
    required this.imageUrl,
    required this.aspectRatio,
    required this.width,
    this.borderRadius,
    this.shimmerBaseColor = ColorPalette.raisinBlack,
    this.shimmerHighlightColor = ColorPalette.cadetGray,
  });
  final String? imageUrl;
  final double aspectRatio;
  final double width;
  final BorderRadius? borderRadius;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl:
                imageUrl ??
                'https://blocks.astratic.com/img/general-img-landscape.png',
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: shimmerBaseColor,
              highlightColor: shimmerHighlightColor.withAlpha(100),
              child: Container(
                width: width,
                height: width / aspectRatio,
                color: ColorPalette.raisinBlack,
              ),
            ),
            errorWidget: (context, url, error) =>
                Icon(Icons.error_outline_rounded, size: 30),
          ),
        ),
      ),
    );
  }
}

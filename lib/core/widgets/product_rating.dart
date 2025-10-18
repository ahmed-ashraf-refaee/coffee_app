import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({
    super.key,
    required this.rating,
    required this.numberOfRatings,
    this.size = 14,
    this.showFiveStars = true,
  });

  final double rating;
  final int numberOfRatings;
  final double size;
  final bool showFiveStars;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: TextStyles.bold14.copyWith(fontSize: size),
        ),
        if (showFiveStars)
          RatingStars(rating: rating, size: size)
        else
          Icon(Ionicons.star, color: context.colors.primary, size: size),
        Text(
          '(${numberOfRatings.toString()})',
          style: TextStyles.regular12.copyWith(
            fontSize: size - 2,
            color: context.colors.onSecondary.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating, this.size = 14});

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    final stars = List.generate(5, (index) {
      final starIndex = index + 1;
      if (rating >= starIndex) {
        return Icon(Ionicons.star, color: context.colors.primary, size: size);
      } else if (rating >= starIndex - 0.5) {
        return Transform.flip(
          flipX: context.isArabic,
          child: Icon(
            Ionicons.star_half,
            color: context.colors.primary,
            size: size,
          ),
        );
      } else {
        return Icon(
          Ionicons.star_outline,
          color: context.colors.primary,
          size: size,
        );
      }
    });

    return Row(spacing: 2, children: stars);
  }
}

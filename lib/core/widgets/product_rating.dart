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
  });

  final double rating;
  final int numberOfRatings;
  final double size;
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

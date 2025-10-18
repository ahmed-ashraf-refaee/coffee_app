import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/core/widgets/product_rating.dart';
import 'package:coffee_app/features/home/data/data/review_model.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class ReviewListItem extends StatelessWidget {
  final ReviewModel review;
  const ReviewListItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        review.profileImageUrl != null
            ? CustomRoundedImage(
                imageUrl: review.profileImageUrl!,
                aspectRatio: 1,
                width: 48,
                borderRadius: BorderRadius.circular(8),
              )
            : SizedBox(
                width: 48,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: context.colors.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      review.firstName[0],
                      style: TextStyles.bold28.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ),
              ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${review.firstName} ${review.lastName}",
                    style: TextStyles.bold16,
                  ),
                  Row(
                    spacing: 4,
                    children: [
                      Text(
                        review.rating.toStringAsFixed(1),
                        style: TextStyles.medium12,
                      ),
                      RatingStars(rating: review.rating),
                    ],
                  ),
                  Text(
                    review.comment.isNotEmpty
                        ? review.comment
                        : S.current.noComment,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

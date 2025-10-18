import 'package:coffee_app/features/home/data/data/review_model.dart';
import 'package:coffee_app/features/home/presentation/view/reviews_view/widgets/review_list_item.dart';
import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  final List<ReviewModel> reviews;
  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: reviews.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) => ReviewListItem(review: reviews[index]),
    );
  }
}

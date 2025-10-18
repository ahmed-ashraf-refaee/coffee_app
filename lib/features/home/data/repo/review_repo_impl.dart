import 'package:coffee_app/core/errors/error_handler.dart';
import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/features/home/data/data/review_model.dart';
import 'package:coffee_app/features/home/data/service/review_service.dart';

import 'package:dartz/dartz.dart';

import 'review_repo.dart';

class ReviewRepoImpl extends ReviewRepo {
  final ReviewService _reviewService = ReviewService();

  @override
  Future<Either<Failure, List<ReviewModel>>> fetchReviews(int productId) {
    return guard(() async {
      final List<Map<String, dynamic>> reviewList = await _reviewService
          .getReviewsByProduct(productId);

      return reviewList.map((review) => ReviewModel.fromJson(review)).toList();
    });
  }

  @override
  Future<Either<Failure, void>> addReview({
    required int productId,
    required String userId,
    required double rating,
    required String comment,
  }) {
    return guard(() async {
      await _reviewService.addReview(
        productId: productId,
        userId: userId,
        rating: rating,
        comment: comment,
      );
    });
  }

  @override
  Future<Either<Failure, ProductModel>> fetchUpdatedProduct(
    int productId,
  ) async {
    return guard(() async {
      final Map<String, dynamic> productJson = await _reviewService
          .fetchUpdatedProduct(productId);
      return ProductModel.fromJson(productJson);
    });
  }
}

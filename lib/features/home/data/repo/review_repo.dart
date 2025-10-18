import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/home/data/data/review_model.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/model/product_model.dart';

abstract class ReviewRepo {
  Future<Either<Failure, List<ReviewModel>>> fetchReviews(int productId);
  Future<Either<Failure, void>> addReview({
    required int productId,
    required String userId,
    required double rating,
    required String comment,
  });
  Future<Either<Failure, ProductModel>> fetchUpdatedProduct(int productId);
}

import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRepo {
  Future<Either<Failure, List<ProductModel>>> getWishlist();
  Future<Either<Failure, void>> addToWishlist({required int productId});
  Future<Either<Failure, void>> removeFromWishlist({required int productId});
  Future<Either<Failure, void>> removeAllWishlist();
  Future<Either<Failure, void>> toggleFavorite({required int productId});
}

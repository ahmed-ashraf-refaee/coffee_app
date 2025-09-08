import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRepo {
  void addToWishlist({required int productId});
  Future<void> removeFromWishlist({required int productId});
  Future<Either<Failure, void>> removeAllWishlist();
  Future<bool> isProductInWishlist({required int productId});
  Future<Either<Failure, List<ProductModel>>> getWishlist();
  Future<Either<Failure, void>> toggleFavourite({required int productId});
}

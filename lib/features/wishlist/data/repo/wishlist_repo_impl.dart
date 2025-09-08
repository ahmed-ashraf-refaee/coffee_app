import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:coffee_app/features/wishlist/data/service/wishlist_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistRepoImpl extends WishlistRepo {
  final WishlistService _wishlistService = WishlistService();
  final String userId = Supabase.instance.client.auth.currentUser!.id;
  @override
  Future<Either<Failure, List<ProductModel>>> getWishlist() async {
    try {
      final List<Map<String, dynamic>> productList = await _wishlistService
          .getFavouriteProducts(userId: userId);
      List<ProductModel> products = productList
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return right(products);
    } catch (e) {
      if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> removeAllWishlist() async {
    try {
      await _wishlistService.removeAll();
      return right(null);
    } catch (e) {
      if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  @override
  Future<void> addToWishlist({required int productId}) async {
    await _wishlistService.addToWishlist(userId: userId, productId: productId);
  }

  @override
  Future<void> removeFromWishlist({required int productId}) async {
    await _wishlistService.removeByProductId(productId: productId);
  }

  @override
  Future<bool> isProductInWishlist({required int productId}) async {
    final currentStatus = await _wishlistService.isProductInWishlist(
      productId: productId,
    );
    print("===========currentStatus=========$currentStatus");
    if (currentStatus.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> toggleFavourite({
    required int productId,
  }) async {
    try {
      final currentStatus = await isProductInWishlist(productId: productId);
      print("===========currentStatus=========$currentStatus");
      if (currentStatus) {
        addToWishlist(productId: productId);
      } else {
        removeFromWishlist(productId: productId);
        print("===========0000000000=========");
      }
      final List<Map<String, dynamic>> productList = await _wishlistService
          .getFavouriteProducts(userId: userId);
      List<ProductModel> products = productList.map((p) {
        return ProductModel.fromJson(p);
      }).toList();
      return right(products);
    } catch (e) {
      if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }
}

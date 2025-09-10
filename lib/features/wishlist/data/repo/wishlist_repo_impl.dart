import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:coffee_app/features/wishlist/data/service/wishlist_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistRepoImpl extends WishlistRepo {
  final WishlistService _wishlistService = WishlistService();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> _cachedWishlist = [];
  Set<int> _wishlistProductIds = <int>{};

  List<ProductModel> getCachedWishlist() => _cachedWishlist;

  @override
  Future<Either<Failure, List<ProductModel>>> getWishlist() async {
    try {
      final List<Map<String, dynamic>> productList = await _wishlistService
          .getFavouriteProducts(userId: userId);
      List<ProductModel> products = productList
          .map((product) => ProductModel.fromJson(product))
          .toList();

      _updateCache(products);

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

      _updateCache([]);

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
  Future<Either<Failure, void>> addToWishlist({required int productId}) async {
    try {
      _wishlistProductIds.add(productId);
      await _wishlistService.addToWishlist(
        userId: userId,
        productId: productId,
      );

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
  Future<Either<Failure, void>> removeFromWishlist({
    required int productId,
  }) async {
    try {
      _wishlistProductIds.remove(productId);
      _cachedWishlist = _cachedWishlist
          .where((p) => p.id != productId)
          .toList();

      await _wishlistService.removeByProductId(productId: productId);

      return right(null);
    } catch (e) {
      if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  bool isProductInWishlistSync({required int productId}) {
    return _wishlistProductIds.contains(productId);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> toggleFavourite({
    required int productId,
  }) async {
    try {
      final isCurrentlyInWishlist = isProductInWishlistSync(
        productId: productId,
      );
      if (isCurrentlyInWishlist) {
        await removeFromWishlist(productId: productId);
      } else {
        await addToWishlist(productId: productId);
      }
      final result = await getWishlist();
      return result;
    } catch (e) {
      if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  void _updateCache(List<ProductModel> products) {
    _cachedWishlist = products;
    _wishlistProductIds = products.map((p) => p.id).toSet();
  }
}

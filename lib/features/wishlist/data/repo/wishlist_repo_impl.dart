import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:coffee_app/features/wishlist/data/service/wishlist_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/error_handler.dart';

class WishlistRepoImpl extends WishlistRepo {
  final WishlistService _wishlistService = WishlistService();
  String get userId => Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> _cachedWishlist = [];
  Set<int> _wishlistProductIds = <int>{};

  List<ProductModel> getCachedWishlist() => _cachedWishlist;

  @override
  Future<Either<Failure, List<ProductModel>>> getWishlist() {
    return guard(() async {
      final List<Map<String, dynamic>> productList = await _wishlistService
          .getFavoriteProducts(userId: userId);
      List<ProductModel> products = productList
          .map((product) => ProductModel.fromJson(product))
          .toList();

      _updateCache(products);

      return products;
    });
  }

  @override
  Future<Either<Failure, void>> removeAllWishlist() {
    return guard(() async {
      await _wishlistService.removeAll(userId);

      _updateCache([]);
    });
  }

  @override
  Future<Either<Failure, void>> addToWishlist({required int productId}) {
    return guard(() async {
      _wishlistProductIds.add(productId);
      await _wishlistService.addToWishlist(
        userId: userId,
        productId: productId,
      );
    });
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist({required int productId}) {
    return guard(() async {
      _wishlistProductIds.remove(productId);
      _cachedWishlist = _cachedWishlist
          .where((p) => p.id != productId)
          .toList();

      await _wishlistService.removeByProductId(
        productId: productId,
        userId: userId,
      );
    });
  }

  bool isProductInWishlistSync({required int productId}) {
    return _wishlistProductIds.contains(productId);
  }

  @override
  Future<Either<Failure, List<ProductModel>>> toggleFavorite({
    required int productId,
  }) {
    return guard(() async {
      final isCurrentlyInWishlist = isProductInWishlistSync(
        productId: productId,
      );
      if (isCurrentlyInWishlist) {
        await removeFromWishlist(productId: productId);
      } else {
        await addToWishlist(productId: productId);
      }
      final result = await getWishlist();
      return result.getOrElse(() => []);
    });
  }

  void _updateCache(List<ProductModel> products) {
    _cachedWishlist = products;
    _wishlistProductIds = products.map((p) => p.id).toSet();
  }

  void clearCache() {
    _cachedWishlist.clear();
    _wishlistProductIds.clear();
  }
}

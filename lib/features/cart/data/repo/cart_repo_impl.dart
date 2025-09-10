import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/features/cart/data/repo/cart_repo.dart';
import 'package:coffee_app/features/cart/data/service/cart_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartRepoImpl extends CartRepo {
  final CartService _cartService = CartService();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  @override
  Future<Either<Failure, void>> addItemToCart({
    required int productVariantId,
    int quantity = 1,
  }) async {
    try {
      await _cartService.addToCart(
        userId: userId,
        productVariantId: productVariantId,
        quantity: quantity,
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
  Future<Either<Failure, List<ProductModel>>> getCartItem() async {
    try {
      final result = await _cartService.getCartItems(userId: userId);

      final items = result
          .map(
            (json) => ProductModel.fromJson({
              ...json['product_variants']['products'],
              'product_variants': json['product_variants'],
            }),
          )
          .toList();

      return right(items);
    } catch (e) {
      if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> removeAll() async {
    try {
      await _cartService.clearCart(userId: userId);
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
  Future<Either<Failure, void>> removeItem({
    required int productVariantId,
  }) async {
    try {
      await _cartService.removeItemByVariant(
        userId: userId,
        productVariantId: productVariantId,
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
  Future<Either<Failure, void>> updateItemQuantity({
    required int productVariantId,
    required int newQuantity,
  }) async {
    try {
      await _cartService.updateQuantity(
        userId: userId,
        productVariantId: productVariantId,
        newQuantity: newQuantity,
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
}

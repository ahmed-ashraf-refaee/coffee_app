import 'package:coffee_app/core/errors/error_handler.dart';
import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/cart/data/model/cart_item_model.dart';
import 'package:coffee_app/features/cart/data/repo/cart_repo.dart';
import 'package:coffee_app/features/cart/data/service/cart_service.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartRepoImpl extends CartRepo {
  final CartService _cartService = CartService();
  String get userId => Supabase.instance.client.auth.currentUser!.id;

  Map<int, CartItemModel> _cartCache = {};

  List<CartItemModel> getCachedCart() => _cartCache.values.toList();

  @override
  Future<Either<Failure, List<CartItemModel>>> getCartItem() {
    return guard(() async {
      final result = await _cartService.getCartItems(userId: userId);

      final items = result.map((json) => CartItemModel.fromJson(json)).toList();

      _updateCache(items);

      return items;
    });
  }

  @override
  Future<Either<Failure, void>> addItemToCart({
    required int productVariantId,
    required int productId,
    int quantity = 1,
  }) {
    return guard(() async {
      final json = await _cartService.addToCart(
        userId: userId,
        productVariantId: productVariantId,
        quantity: quantity,
        productId: productId,
      );

      final item = CartItemModel.fromJson(json);
      _cartCache[item.id] = item;
    });
  }

  @override
  Future<Either<Failure, void>> removeAll() {
    return guard(() async {
      _cartCache.clear();
      await _cartService.clearCart(userId: userId);
    });
  }

  @override
  Future<Either<Failure, void>> removeItem({required int cartItemId}) {
    return guard(() async {
      _cartCache.remove(cartItemId);
      await _cartService.removeItemById(cartItemId: cartItemId);
    });
  }

  @override
  Future<Either<Failure, void>> updateItemQuantity({
    required int cartItemId,
    required int newQuantity,
  }) {
    return guard(() async {
      final json = await _cartService.updateQuantityById(
        cartItemId: cartItemId,
        newQuantity: newQuantity,
      );

      final item = CartItemModel.fromJson(json);
      _cartCache[item.id] = item;
    });
  }

  void _updateCache(List<CartItemModel> items) {
    _cartCache = {for (var item in items) item.id: item};
  }

  void clearCache() {
    _cartCache.clear();
  }
}

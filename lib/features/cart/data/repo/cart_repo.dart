import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/cart/data/model/cart_item_model.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepo {
  Future<Either<Failure, List<CartItemModel>>> getCartItem();
  Future<Either<Failure, void>> addItemToCart({
    required int selectedVariantIndex,
    required int productId,

    required int quantity,
  });

  Future<Either<Failure, void>> updateItemQuantity({
    required int cartItemId,
    required int newQuantity,
  });
  Future<Either<Failure, void>> removeItem({required int cartItemId});
  Future<Either<Failure, void>> removeAll();
}

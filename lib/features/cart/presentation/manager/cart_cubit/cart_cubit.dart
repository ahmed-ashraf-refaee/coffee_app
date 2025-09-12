import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/cart/data/model/cart_item_model.dart';
import 'package:coffee_app/features/cart/data/repo/cart_repo_impl.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final CartRepoImpl _cartRepo = CartRepoImpl();

  Future<void> loadCart() async {
    emit(CartLoading());
    final result = await _cartRepo.getCartItem();
    result.fold(
      (failure) => emit(CartFailure(error: failure.error)),
      (items) => emit(CartSuccess(cartItems: items)),
    );
  }

  Future<void> addItem({
    required int productVariantId,
    required int productId,
    int quantity = 1,
  }) async {
    final result = await _cartRepo.addItemToCart(
      productVariantId: productVariantId,
      quantity: quantity,
      productId: productId,
    );
    result.fold(
      (failure) => emit(CartFailure(error: failure.error)),
      (_) => emit(CartSuccess(cartItems: _cartRepo.getCachedCart())),
    );
  }

  Future<void> removeItem({required int productVariantId}) async {
    final result = await _cartRepo.removeItem(
      productVariantId: productVariantId,
    );
    result.fold(
      (failure) => emit(CartFailure(error: failure.error)),
      (_) => emit(CartSuccess(cartItems: _cartRepo.getCachedCart())),
    );
  }

  Future<void> updateQuantity({
    required int productVariantId,
    required int newQuantity,
  }) async {
    final result = await _cartRepo.updateItemQuantity(
      productVariantId: productVariantId,
      newQuantity: newQuantity,
    );
    result.fold(
      (failure) => emit(CartFailure(error: failure.error)),
      (_) => emit(CartSuccess(cartItems: _cartRepo.getCachedCart())),
    );
  }

  Future<void> clearCart() async {
    final result = await _cartRepo.removeAll();
    result.fold(
      (failure) => emit(CartFailure(error: failure.error)),
      (_) => emit(CartSuccess(cartItems: const [])),
    );
  }
}

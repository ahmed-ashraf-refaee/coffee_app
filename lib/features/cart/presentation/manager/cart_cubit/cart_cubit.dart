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

  Future<void> removeItem({required int cartItemId}) async {
    final currentProducts = _cartRepo.getCachedCart();
    emit(
      CartSuccess(
        cartItems: currentProducts
            .where((item) => item.id != cartItemId)
            .toList(),
      ),
    );
    final result = await _cartRepo.removeItem(cartItemId: cartItemId);
    result.fold(
      (failure) => emit(CartFailure(error: failure.error)),
      (_) => emit(CartSuccess(cartItems: _cartRepo.getCachedCart())),
    );
  }

  Future<void> updateQuantity({
    required int cartItemId,
    required int newQuantity,
  }) async {
    final currentProducts = _cartRepo.getCachedCart();
    final updatedItems = currentProducts.map((item) {
      if (item.id == cartItemId) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();
    emit(CartSuccess(cartItems: updatedItems));
    final result = await _cartRepo.updateItemQuantity(
      cartItemId: cartItemId,
      newQuantity: newQuantity,
    );
    result.fold((failure) => emit(CartFailure(error: failure.error)), (_) {
      final currentItem = _cartRepo.getCachedCart();

      if (currentItem != updatedItems) {
        emit(CartSuccess(cartItems: currentItem));
      }
    });
  }

  Future<void> clearCart() async {
    final currentCartProducts = _cartRepo.getCachedCart();
    emit(CartSuccess(cartItems: const []));
    final result = await _cartRepo.removeAll();
    result.fold((failure) {
      emit(CartSuccess(cartItems: currentCartProducts));
      emit(CartFailure(error: failure.error));
    }, (_) => emit(CartSuccess(cartItems: const [])));
  }
}

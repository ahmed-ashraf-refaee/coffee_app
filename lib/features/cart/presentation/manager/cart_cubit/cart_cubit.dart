import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/cart/data/model/cart_item_model.dart';
import 'package:coffee_app/features/cart/data/repo/cart_repo_impl.dart';
import 'package:meta/meta.dart';

import '../../../../checkout/data/models/order_item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final CartRepoImpl cartRepo = CartRepoImpl();

  Future<void> loadCart() async {
    emit(CartLoading());
    final result = await cartRepo.getCartItem();
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
    emit(CartAddItemLoading(productId: productId));
    final result = await cartRepo.addItemToCart(
      productVariantId: productVariantId,
      quantity: quantity,
      productId: productId,
    );
    result.fold(
      (failure) => emit(CartFailure(error: failure.error)),
      (_) => emit(CartSuccess(cartItems: cartRepo.getCachedCart())),
    );
  }

  Future<void> removeItem({required int cartItemId}) async {
    final currentProducts = cartRepo.getCachedCart();
    emit(
      CartSuccess(
        cartItems: currentProducts
            .where((item) => item.id != cartItemId)
            .toList(),
      ),
    );
    final result = await cartRepo.removeItem(cartItemId: cartItemId);
    result.fold(
      (failure) => emit(CartFailure(error: failure.error)),
      (_) => emit(CartSuccess(cartItems: cartRepo.getCachedCart())),
    );
  }

  Future<void> updateQuantity({
    required int cartItemId,
    required int newQuantity,
  }) async {
    emit(CartItemLoading(id: cartItemId));
    final result = await cartRepo.updateItemQuantity(
      cartItemId: cartItemId,
      newQuantity: newQuantity,
    );
    result.fold((failure) => emit(CartFailure(error: failure.error)), (_) {
      final currentItem = cartRepo.getCachedCart();

      emit(CartSuccess(cartItems: currentItem));
    });
  }

  Future<void> clearCart() async {
    final currentCartProducts = cartRepo.getCachedCart();
    emit(CartSuccess(cartItems: const []));
    final result = await cartRepo.removeAll();
    result.fold((failure) {
      emit(CartSuccess(cartItems: currentCartProducts));
      emit(CartFailure(error: failure.error));
    }, (_) => emit(CartSuccess(cartItems: const [])));
  }

  List<OrderItemModel> getOrderItemsFromCachedCart() {
    final cachedCart = cartRepo.getCachedCart();
    return cachedCart.map((item) => item.toOrderItem()).toList();
  }
}

import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/wishlist/data/repo/wishlist_repo_impl.dart';
import 'package:meta/meta.dart';

import '../../../../../core/model/product_model.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  final WishlistRepoImpl _wishlistRepoImpl = WishlistRepoImpl();
  getWishlist() async {
    emit(WishlistLoading());
    final result = await _wishlistRepoImpl.getWishlist();
    result.fold(
      (failure) => emit(WishlistFailure(error: failure.error)),
      (response) => emit(WishlistSuccess(products: response)),
    );
  }

  removeAllWishlist() async {
    final result = await _wishlistRepoImpl.removeAllWishlist();
    result.fold(
      (failure) => emit(WishlistFailure(error: failure.error)),
      (response) => emit(WishlistSuccess(products: const [])),
    );
  }

  toggleFavourite({required ProductModel product}) async {
    bool currentStatus = await _wishlistRepoImpl.isProductInWishlist(
      productId: product.id,
    );
    print("===========currentStatus=========$currentStatus");
    if (!currentStatus) {
      _wishlistRepoImpl.addToWishlist(productId: product.id);
    } else {
      _wishlistRepoImpl.removeFromWishlist(productId: product.id);
    }
    final result = await _wishlistRepoImpl.getWishlist();
    result.fold(
      (failure) => emit(WishlistFailure(error: failure.error)),
      (response) => emit(WishlistSuccess(products: response)),
    );
  }
}

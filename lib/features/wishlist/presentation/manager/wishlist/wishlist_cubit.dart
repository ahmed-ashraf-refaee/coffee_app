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
    final currentProducts = _wishlistRepoImpl.getCachedWishlist();
    emit(WishlistSuccess(products: const []));
    final result = await _wishlistRepoImpl.removeAllWishlist();
    result.fold(
      (failure) {
        emit(WishlistSuccess(products: currentProducts));
        emit(WishlistFailure(error: failure.error));
      },
      (response) {
        emit(WishlistSuccess(products: const []));
      },
    );
  }

  bool isFavourite({required int productId}) {
    return _wishlistRepoImpl.isProductInWishlistSync(productId: productId);
  }

  toggleFavourite({required ProductModel product}) async {
    final currentProducts = _wishlistRepoImpl.getCachedWishlist();
    final isCurrentlyFavorite = isFavourite(productId: product.id);
    List<ProductModel> optimisticProducts;
    if (isCurrentlyFavorite) {
      optimisticProducts = currentProducts
          .where((p) => p.id != product.id)
          .toList();
    } else {
      optimisticProducts = [product, ...currentProducts];
    }
    emit(WishlistSuccess(products: optimisticProducts));
    final result = await _wishlistRepoImpl.toggleFavourite(
      productId: product.id,
    );

    result.fold(
      (failure) {
        emit(WishlistSuccess(products: currentProducts));
        emit(WishlistFailure(error: failure.error));
      },
      (serverProducts) {
        emit(WishlistSuccess(products: serverProducts));
      },
    );
  }
}

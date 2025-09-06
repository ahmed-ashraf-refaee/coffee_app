part of 'home_top_products_cubit.dart';

@immutable
sealed class HomeTopProductsState {}

final class HomeTopProductsInitial extends HomeTopProductsState {}

final class TopProductsSuccess extends HomeTopProductsState {
  final List<ProductModel> products;
  TopProductsSuccess({required this.products});
}

final class TopProductsLoading extends HomeTopProductsState {}

final class TopProductsFailure extends HomeTopProductsState {
  final String error;
  TopProductsFailure({required this.error});
}

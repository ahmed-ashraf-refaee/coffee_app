part of 'home_product_cubit.dart';

@immutable
sealed class HomeProductState {}

final class HomeProductInitial extends HomeProductState {}

final class HomeProductsDataSuccess extends HomeProductState {
  final List<ProductModel> products;

  HomeProductsDataSuccess({required this.products});
}

// final class HomeProductsFiltered extends HomeProductState {
//   final List<ProductModel> filteredProducts;

//   HomeProductsFiltered({required this.filteredProducts});
// }

final class HomeProductsDataLoading extends HomeProductState {}

final class HomeProductsDataFailure extends HomeProductState {
  final String error;
  HomeProductsDataFailure({required this.error});
}

part of 'home_data_cubit.dart';

@immutable
sealed class HomeDataState {}

final class HomeDataInitial extends HomeDataState {}

//fetch_products states
final class HomeProductsDataSuccess extends HomeDataState {
  final List<ProductModel> products;
  HomeProductsDataSuccess({required this.products});
}

final class HomeProductsDataLoading extends HomeDataState {}

final class HomeProductsDataFailure extends HomeDataState {
  final String error;
  HomeProductsDataFailure({required this.error});
}

//Top Product states
final class HomeTopProductsDataSuccess extends HomeDataState {
  final List<ProductModel> products;
  HomeTopProductsDataSuccess({required this.products});
}

final class HomeTopProductsDataLoading extends HomeDataState {}

final class HomeTopProductsDataFailure extends HomeDataState {
  final String error;
  HomeTopProductsDataFailure({required this.error});
}

//fetch_categories states
final class HomeProductCategoriesSuccess extends HomeDataState {
  final List<CategoriesModel> catigories;
  HomeProductCategoriesSuccess({required this.catigories});
}

final class HomeProductCategoriesLoading extends HomeDataState {}

final class HomeProductCategoriesFailure extends HomeDataState {
  final String error;
  HomeProductCategoriesFailure({required this.error});
}

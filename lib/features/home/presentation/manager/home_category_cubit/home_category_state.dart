part of 'home_category_cubit.dart';

@immutable
sealed class HomeCategoryState {}

final class HomeCategoryInitial extends HomeCategoryState {}

final class ProductCategoriesSuccess extends HomeCategoryState {
  final List<CategoriesModel> category;

  ProductCategoriesSuccess({required this.category});
}

final class ProductCategoriesLoading extends HomeCategoryState {}

final class ProductCategoriesFailure extends HomeCategoryState {
  final String error;
  ProductCategoriesFailure({required this.error});
}

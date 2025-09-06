import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/home/data/model/product_model.dart';
import 'package:coffee_app/features/home/data/repo/home_repo_impl.dart';
import 'package:meta/meta.dart';

import '../../../data/service/filters/filter_products.dart';
import '../../../data/service/filters/filter_strategy.dart';

part 'home_product_state.dart';

class HomeProductCubit extends Cubit<HomeProductState> {
  HomeProductCubit() : super(HomeProductInitial());

  final HomeRepoImpl _homeRepoImpl = HomeRepoImpl();
  String selectedCategoryName = 'All';
  String searchQuery = '';
  List<ProductModel> products = [];
  Future<void> getProducts() async {
    emit(HomeProductsDataLoading());
    final result = await _homeRepoImpl.fetchProducts();
    result.fold(
      (failure) => emit(HomeProductsDataFailure(error: failure.error)),
      (response) {
        products = response;
        emit(HomeProductsDataSuccess(products: products));
      },
    );
  }

  void updateFilters({
    String? category,
    String? query,
    List<FilterStrategy> strategies = const [],
  }) {
    if (category != null) selectedCategoryName = category;
    if (query != null) searchQuery = query;

    final filteredProducts = FilterProducts(
      strategies: [
        SearchFilter(enabled: searchQuery.isNotEmpty, searchQuery: searchQuery),
        CategoryFilter(
          enabled: selectedCategoryName != "All",
          categoryName: selectedCategoryName,
        ),
        ...strategies,
      ],
    ).apply(products);

    emit(HomeProductsDataSuccess(products: filteredProducts));
  }
}

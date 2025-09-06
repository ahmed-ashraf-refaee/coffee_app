import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/home/data/model/categories_model.dart';
import 'package:coffee_app/features/home/data/model/product_model.dart';
import 'package:coffee_app/features/home/data/repo/home_repo_impl.dart';
import 'package:meta/meta.dart';

part 'home_data_state.dart';

class HomeDataCubit extends Cubit<HomeDataState> {
  HomeDataCubit() : super(HomeDataInitial());

  final HomeRepoImpl _homeRepoImpl = HomeRepoImpl();
  List<ProductModel> products = [];
  List<CategoriesModel> categories = [];
  String selectedCategoryName = "All";

  Future<void> getProducts() async {
    emit(HomeProductsDataLoading());
    final result = await _homeRepoImpl.fetchProducts();
    result.fold(
      (failure) => emit(HomeProductsDataFailure(error: failure.error)),
      (response) {
        products = response;
      },
    );
  }

  loadHomeData() async {
    await getCategories();
    await getProducts();
    emit(HomeProductsDataSuccess());
  }

  Future<void> getTopProducts() async {
    emit(HomeTopProductsDataLoading());
    final result = await _homeRepoImpl.fetchTopPicks();
    result.fold(
      (failure) => emit(HomeTopProductsDataFailure(error: failure.error)),
      (response) => emit(HomeTopProductsDataSuccess(products: response)),
    );
  }

  Future<void> getCategories() async {
    emit(HomeProductCategoriesLoading());
    final result = await _homeRepoImpl.fetchCategories();
    result.fold(
      (failure) => emit(HomeProductCategoriesFailure(error: failure.error)),
      (categoryList) {
        categories = categoryList;
      },
    );
  }
}

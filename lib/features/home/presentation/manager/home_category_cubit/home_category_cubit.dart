import 'package:bloc/bloc.dart';
import 'package:coffee_app/core/model/categories_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repo/home_repo_impl.dart';

part 'home_category_state.dart';

class HomeCategoryCubit extends Cubit<HomeCategoryState> {
  HomeCategoryCubit() : super(HomeCategoryInitial());
  final HomeRepoImpl _homeRepoImpl = HomeRepoImpl();

  Future<void> getCategories() async {
    emit(ProductCategoriesLoading());
    final result = await _homeRepoImpl.fetchCategories();
    result.fold(
      (failure) => emit(ProductCategoriesFailure(error: failure.error)),
      (categoryList) {
        emit(ProductCategoriesSuccess(category: categoryList));
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/product_model.dart';
import '../../../data/repo/home_repo_impl.dart';

part 'home_top_products_state.dart';

class HomeTopProductsCubit extends Cubit<HomeTopProductsState> {
  HomeTopProductsCubit() : super(HomeTopProductsInitial());
  final HomeRepoImpl _homeRepoImpl = HomeRepoImpl();

  Future<void> getTopProducts() async {
    emit(TopProductsLoading());
    final result = await _homeRepoImpl.fetchTopPicks();
    result.fold(
      (failure) => emit(TopProductsFailure(error: failure.error)),
      (response) => emit(TopProductsSuccess(products: response)),
    );
  }
}

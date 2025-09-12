import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/home/data/model/product_model.dart';
import 'package:coffee_app/features/home/data/repo/home_repo_impl.dart';
import 'package:coffee_app/features/home/data/service/filters/filter_service.dart';
import 'package:coffee_app/features/home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';
import 'package:meta/meta.dart';

part 'home_product_state.dart';

class HomeProductCubit extends Cubit<HomeProductState> {
  final HomeRepoImpl _homeRepoImpl = HomeRepoImpl();
  final HomeFilterCubit filterCubit;
  late final FilterService _filterService;
  late final StreamSubscription _filterSub;

  List<ProductModel> _allProducts = [];

  HomeProductCubit(this.filterCubit) : super(HomeProductInitial()) {
    _filterService = FilterService(filterCubit: filterCubit);

    // listen for filter changes
    _filterSub = filterCubit.stream.listen((_) {
      _emitFiltered();
    });
  }

  Future<void> getProducts() async {
    emit(HomeProductsDataLoading());
    final result = await _homeRepoImpl.fetchProducts();
    result.fold(
      (failure) => emit(HomeProductsDataFailure(error: failure.error)),
      (response) {
        _allProducts = response;
        _emitFiltered();
      },
    );
  }

  void _emitFiltered() {
    final filtered = _filterService.applyFilters(_allProducts);
    emit(HomeProductsDataSuccess(products: filtered));
  }

  @override
  Future<void> close() {
    _filterSub.cancel();
    return super.close();
  }
}

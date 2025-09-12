import 'package:coffee_app/features/home/data/service/filters/filter_products.dart';
import 'package:coffee_app/features/home/data/service/filters/filter_strategy.dart';
import 'package:coffee_app/features/home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';

import '../../model/product_model.dart';

class FilterService {
  final HomeFilterCubit filterCubit;

  FilterService({required this.filterCubit});
  List<ProductModel> applyFilters(List<ProductModel> products) {
    final state = filterCubit.state;
    List<FilterStrategy> strategies = [
      SearchFilter(
        enabled: state.searchQuery.isNotEmpty,
        searchQuery: state.searchQuery,
      ),
      CategoryFilter(
        enabled: state.category != "All",
        categoryName: state.category,
      ),
      SortingFilter(enabled: state.sorting.isNotEmpty, sorting: state.sorting),
      RatingFilter(enabled: state.rating.isNotEmpty, rating: state.rating),
      PriceRangeFilter(enabled: true, priceRange: state.priceRange),
    ];

    return FilterProducts(strategies: strategies).apply(products);
  }
}

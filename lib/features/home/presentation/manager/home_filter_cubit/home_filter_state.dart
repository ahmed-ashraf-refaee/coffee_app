part of 'home_filter_cubit.dart';

@immutable
class HomeFilterState {
  final String searchQuery;
  final RangeValues priceRange;
  final String category;
  final String sorting;
  final String rating;

  HomeFilterState({
    this.searchQuery = '',
    this.priceRange = const RangeValues(
      FilterConstants.minPrice,
      FilterConstants.maxPrice,
    ),
    String? category,
    this.sorting = '',
    this.rating = '',
  }) : category = category ?? S.current.all;

  HomeFilterState copyWith({
    String? searchQuery,
    RangeValues? priceRange,
    String? category,
    String? sorting,
    String? rating,
  }) {
    return HomeFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      priceRange: priceRange ?? this.priceRange,
      category: category ?? this.category,
      sorting: sorting ?? this.sorting,
      rating: rating ?? this.rating,
    );
  }
}

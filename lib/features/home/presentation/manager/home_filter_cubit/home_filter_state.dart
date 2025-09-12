part of 'home_filter_cubit.dart';

@immutable
class HomeFilterState {
  final String searchQuery;
  final RangeValues priceRange;
  final String category;
  final String sorting;
  final String rating;

  const HomeFilterState({
    this.searchQuery = '',
    this.priceRange = const RangeValues(
      FilterConstants.minPrice,
      FilterConstants.maxPrice,
    ),
    this.category = 'All',
    this.sorting = '',
    this.rating = '',
  });

  HomeFilterState copyWith({
    final String? searchQuery,
    final RangeValues? priceRange,
    final String? category,
    final String? sorting,
    final String? rating,
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


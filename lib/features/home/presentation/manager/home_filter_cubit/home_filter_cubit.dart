import 'package:bloc/bloc.dart';
import 'package:coffee_app/core/constants/filter_constants.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';

part 'home_filter_state.dart';

class HomeFilterCubit extends Cubit<HomeFilterState> {
  HomeFilterCubit() : super(HomeFilterState());
  String selectedCategory = S.current.all;
  String selectedQuery = '';
  RangeValues selectedPriceRange = const RangeValues(
    FilterConstants.minPrice,
    FilterConstants.maxPrice,
  );
  String selectedSort = '';
  String selectedRating = '';

  void setSearch() => emit(state.copyWith(searchQuery: selectedQuery));
  void setCategory() => emit(state.copyWith(category: selectedCategory));

  void setFilters() => emit(
    state.copyWith(
      priceRange: selectedPriceRange,
      rating: selectedRating,
      sorting: selectedSort,
    ),
  );

  void resetFilters() {
    selectedPriceRange = const RangeValues(
      FilterConstants.minPrice,
      FilterConstants.maxPrice,
    );
    selectedSort = '';
    selectedRating = '';
    emit(state.copyWith());
  }

  void revert() {
    selectedPriceRange = state.priceRange;
    selectedSort = state.sorting;
    selectedRating = state.rating;
  }

  bool isFiltered() {
    return state.sorting.isNotEmpty ||
        state.rating.isNotEmpty ||
        state.priceRange.start != FilterConstants.minPrice ||
        state.priceRange.end != FilterConstants.maxPrice;
  }

  void resetAll() {
    selectedCategory = S.current.all;
    print(selectedCategory);
    selectedQuery = '';
    selectedPriceRange = const RangeValues(
      FilterConstants.minPrice,
      FilterConstants.maxPrice,
    );
    selectedSort = '';
    selectedRating = '';
    emit(HomeFilterState());
  }
}

import 'package:bloc/bloc.dart';
import 'package:coffee_app/core/constants/filter_constants.dart';
import 'package:flutter/material.dart';

part 'home_filter_state.dart';

class HomeFilterCubit extends Cubit<HomeFilterState> {
  HomeFilterCubit() : super(const HomeFilterState());
  void setSearch(String query) => emit(state.copyWith(searchQuery: query));

  void setCategory(String category) => emit(state.copyWith(category: category));

  void setFilters({
    required RangeValues range,
    required String rating,
    required String sorting,
  }) =>
      emit(state.copyWith(priceRange: range, rating: rating, sorting: sorting));

  void resetFilters() => emit(
    state.copyWith(
      priceRange: const RangeValues(
        FilterConstants.minPrice,
        FilterConstants.maxPrice,
      ),
      rating: '',
      sorting: '',
    ),
  );
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigator_state.dart';

class AppNavigatorCubit extends Cubit<AppNavigatorState> {
  AppNavigatorCubit() : super(AppNavigatorToHomeView());
  int currentIndex = 0;
  setCurrentIndex(int index) {
    currentIndex = index;
    if (index == 0) {
      emit(AppNavigatorToHomeView());
    } else if (index == 1) {
      emit(AppNavigatorToCartView());
    } else if (index == 2) {
      emit(AppNavigatorToWishlistView());
    } else {
      emit(AppNavigatorToProfileView());
    }
  }
}

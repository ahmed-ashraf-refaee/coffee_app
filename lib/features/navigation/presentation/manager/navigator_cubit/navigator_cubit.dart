import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigator_state.dart';

class AppNavigatorCubit extends Cubit<AppNavigatorState> {
  AppNavigatorCubit() : super(AppNavigatorToHomeView());
  int currentIndex = 0;
  setCurrentIndex(int index) {
    if (index == 0) {
      currentIndex = index;
      emit(AppNavigatorToHomeView());
    } else if (index == 1) {
      currentIndex = index;
      emit(AppNavigatorToCartView());
    } else if (index == 2) {
      currentIndex = index;
      emit(AppNavigatorToWishlistView());
    } else {
      currentIndex = index;

      emit(AppNavigatorToProfileView());
    }
  }
}

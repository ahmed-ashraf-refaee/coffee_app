part of 'navigator_cubit.dart';

@immutable
sealed class AppNavigatorState {}

final class AppNavigatorToHomeView extends AppNavigatorState {}

final class AppNavigatorToCartView extends AppNavigatorState {}

final class AppNavigatorToWishlistView extends AppNavigatorState {}

final class AppNavigatorToProfileView extends AppNavigatorState {}

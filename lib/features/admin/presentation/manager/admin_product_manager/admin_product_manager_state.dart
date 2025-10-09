part of 'admin_product_manager_cubit.dart';

@immutable
sealed class AdminProductManagerState {}

final class AdminProductManagerInitial extends AdminProductManagerState {}

final class AdminProductLoading extends AdminProductManagerState {}

final class AdminProductSuccess extends AdminProductManagerState {}

final class AdminProductFailure extends AdminProductManagerState {
  final String error;

  AdminProductFailure({required this.error});
}

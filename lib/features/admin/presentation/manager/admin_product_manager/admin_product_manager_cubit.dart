import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/admin/data/repo/admin_repo_impl.dart';
import 'package:meta/meta.dart';

import '../../../../../core/model/product_model.dart';

part 'admin_product_manager_state.dart';

class AdminProductManagerCubit extends Cubit<AdminProductManagerState> {
  AdminProductManagerCubit() : super(AdminProductManagerInitial());
  final AdminRepoImpl _repo = AdminRepoImpl();

  Future<void> createProduct(
    ProductModel product, {
    String languageCode = 'en',
  }) async {
    emit(AdminProductLoading());

    final result = await _repo.createProduct(
      product,
      languageCode: languageCode,
    );

    result.fold(
      (failure) => emit(AdminProductFailure(error: failure.error)),
      (_) => emit(AdminProductSuccess()),
    );
  }

  Future<void> updateProduct(
    ProductModel product, {
    String languageCode = 'en',
  }) async {
    emit(AdminProductLoading());
    final result = await _repo.updateProduct(
      product,
      languageCode: languageCode,
    );
    result.fold(
      (failure) => emit(AdminProductFailure(error: failure.error)),
      (_) => emit(AdminProductSuccess()),
    );
  }
}

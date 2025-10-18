import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/checkout/data/models/order_item.dart';
import 'package:coffee_app/features/checkout/data/models/order_model.dart';
import 'package:meta/meta.dart';

import '../../../data/repo/order/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepo _orderRepo;

  OrderCubit(this._orderRepo) : super(OrderInitial());

  void createOrder(OrderModel order, List<OrderItemModel> items) async {
    emit(OrderLoading());
    final result = await _orderRepo.createOrder(order, items);
    result.fold(
      (failure) => emit(OrderError(failure.error)),
      (orderId) => emit(OrderCreated(orderId)),
    );
  }

  void fetchUserOrders() async {
    emit(OrderLoading());
    final result = await _orderRepo.fetchUserOrders();
    result.fold(
      (failure) => emit(OrderError(failure.error)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  void fetchOrderDetails(int orderId) async {
    emit(OrderLoading());
    final result = await _orderRepo.fetchOrderDetails(orderId);
    result.fold((failure) => emit(OrderError(failure.error)), (data) {
      final order = data['order'] as OrderModel;
      final items = data['items'] as List<OrderItemModel>;
      emit(OrderDetailsLoaded(order, items));
    });
  }

  void updateOrderStatus(int orderId, String status) async {
    emit(OrderUpdating());
    final result = await _orderRepo.updateOrderStatus(orderId, status);
    result.fold(
      (failure) => emit(OrderError(failure.error)),
      (_) => emit(OrderUpdated(status)),
    );
  }

  void deleteOrder(int orderId) async {
    emit(OrderLoading());
    final result = await _orderRepo.deleteOrder(orderId);
    result.fold(
      (failure) => emit(OrderError(failure.error)),
      (_) => emit(OrderDeleted()),
    );
  }
}

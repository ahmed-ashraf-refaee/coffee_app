part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderUpdating extends OrderState {}

final class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}

final class OrderCreated extends OrderState {
  final int orderId;
  OrderCreated(this.orderId);
}

final class OrdersLoaded extends OrderState {
  final List<OrderModel> orders;
  OrdersLoaded(this.orders);
}

final class OrderDetailsLoaded extends OrderState {
  final OrderModel order;
  final List<OrderItemModel> items;
  OrderDetailsLoaded(this.order, this.items);
}

final class OrderUpdated extends OrderState {
  final String status;
  OrderUpdated(this.status);
}

final class OrderDeleted extends OrderState {}

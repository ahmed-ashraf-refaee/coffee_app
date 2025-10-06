import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/checkout/data/models/order_model.dart';
import 'package:dartz/dartz.dart';

import '../../models/order_item.dart';

abstract class OrderRepo {
  Future<Either<Failure, int>> createOrder(
    OrderModel order,
    List<OrderItemModel> items,
  );

  Future<Either<Failure, List<OrderModel>>> fetchUserOrders();

  Future<Either<Failure, Map<String, dynamic>>> fetchOrderDetails(int orderId);

  Future<Either<Failure, void>> updateOrderStatus(
    int orderId,
    String newStatus,
  );

  Future<Either<Failure, void>> deleteOrder(int orderId);
}

import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/checkout/data/models/order_item.dart';
import 'package:coffee_app/features/checkout/data/models/order_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/errors/error_handler.dart';
import 'order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  Future<Either<Failure, int>> createOrder(
    OrderModel order,
    List<OrderItemModel> items,
  ) {
    return guard(() async {
      final orderResponse = await _supabase
          .from('orders')
          .insert(order.toJson())
          .select('id')
          .single();

      final int orderId = orderResponse['id'];

      final List<Map<String, dynamic>> itemData = items
          .map((e) => e.copyWith(orderId: orderId).toJson())
          .toList();

      await _supabase.from('order_item').insert(itemData);

      return orderId;
    });
  }

  @override
  Future<Either<Failure, List<OrderModel>>> fetchUserOrders() {
    return guard(() async {
      final userId = _supabase.auth.currentUser!.id;

      final response = await _supabase
          .from('orders')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List).map((e) => OrderModel.fromJson(e)).toList();
    });
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchOrderDetails(int orderId) {
    return guard(() async {
      final orderResponse = await _supabase
          .from('orders')
          .select()
          .eq('id', orderId)
          .single();

      final itemsResponse = await _supabase
          .from('order_item')
          .select()
          .eq('order_id', orderId);

      final order = OrderModel.fromJson(orderResponse);
      final items = (itemsResponse as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList();

      return {'order': order, 'items': items};
    });
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus(
    int orderId,
    String newStatus,
  ) {
    return guard(() async {
      await _supabase
          .from('orders')
          .update({'status': newStatus})
          .eq('id', orderId);
    });
  }

  @override
  Future<Either<Failure, void>> deleteOrder(int orderId) {
    return guard(() async {
      await _supabase.from('order_item').delete().eq('order_id', orderId);

      await _supabase.from('orders').delete().eq('id', orderId);
    });
  }
}

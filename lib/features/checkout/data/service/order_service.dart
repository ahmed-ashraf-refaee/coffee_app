import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/order_item.dart';
import '../models/order_model.dart';

class OrderService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Create Order
  Future<int> createOrder(OrderModel order) async {
    final response = await _supabase
        .from('orders')
        .insert(order.toJson())
        .select('id')
        .single();
    return response['id'] as int;
  }

  // Fetch All Orders for Current User
  Future<List<OrderModel>> fetchUserOrders() async {
    final userId = _supabase.auth.currentUser!.id;
    final response = await _supabase
        .from('orders')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((e) => OrderModel.fromJson(e)).toList();
  }

  // Fetch Single Order
  Future<OrderModel?> fetchOrderById(int orderId) async {
    final response = await _supabase
        .from('orders')
        .select()
        .eq('id', orderId)
        .maybeSingle();

    if (response == null) return null;
    return OrderModel.fromJson(response);
  }

  // Update Order Status
  Future<void> updateOrderStatus(int orderId, String newStatus) async {
    await _supabase
        .from('orders')
        .update({'status': newStatus})
        .eq('id', orderId);
  }

  // Delete Order
  Future<void> deleteOrder(int orderId) async {
    await _supabase.from('orders').delete().eq('id', orderId);
  }

  // Create Order Item
  Future<void> createOrderItem(OrderItemModel item) async {
    await _supabase.from('order_item').insert(item.toJson());
  }

  // Fetch All Items for an Order
  Future<List<OrderItemModel>> fetchItemsByOrder(int orderId) async {
    final response = await _supabase
        .from('order_item')
        .select()
        .eq('order_id', orderId);

    return (response as List).map((e) => OrderItemModel.fromJson(e)).toList();
  }

  // Update Item Quantity
  Future<void> updateItemQuantity(int itemId, int newQuantity) async {
    await _supabase
        .from('order_item')
        .update({'quantity': newQuantity})
        .eq('id', itemId);
  }

  // Delete Item
  Future<void> deleteItem(int itemId) async {
    await _supabase.from('order_item').delete().eq('id', itemId);
  }
}

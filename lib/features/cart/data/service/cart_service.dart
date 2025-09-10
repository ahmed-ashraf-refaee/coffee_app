import 'package:supabase_flutter/supabase_flutter.dart';

class CartService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<Map<String, dynamic>> getOrCreateCart({required String userId}) async {
    final response = await _supabaseClient
        .from('carts')
        .select()
        .eq('user_id', userId)
        .limit(1);

    if (response.isEmpty) {
      final inserted = await _supabaseClient
          .from('carts')
          .insert({'user_id': userId})
          .select()
          .single();
      return inserted;
    }

    return response.first;
  }

  Future<List<Map<String, dynamic>>> getCartItems({
    required String userId,
  }) async {
    final cart = await getOrCreateCart(userId: userId);

    final response = await _supabaseClient
        .from('cart_item')
        .select('''
          *,
          product_variants(*, products(*, categories(*)))
        ''')
        .eq('cart_id', cart['id'])
        .order('created_at', ascending: false);
    return response;
  }

  Future<void> addToCart({
    required String userId,
    required int productVariantId,
    int quantity = 1,
  }) async {
    final cart = await getOrCreateCart(userId: userId);

    final existing = await _supabaseClient
        .from('cart_item')
        .select()
        .eq('cart_id', cart['id'])
        .eq('product_variant_id', productVariantId)
        .maybeSingle();

    if (existing != null) {
      final newQty = (existing['quantity'] as int) + quantity;
      await updateQuantity(
        userId: userId,
        productVariantId: productVariantId,
        newQuantity: newQty,
      );
    } else {
      await _supabaseClient.from('cart_item').insert({
        'cart_id': cart['id'],
        'product_variant_id': productVariantId,
        'quantity': quantity,
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<void> updateQuantity({
    required String userId,
    required int productVariantId,
    required int newQuantity,
  }) async {
    final cart = await getOrCreateCart(userId: userId);
    await _supabaseClient
        .from('cart_item')
        .update({'quantity': newQuantity})
        .eq('cart_id', cart['id'])
        .eq('product_variant_id', productVariantId);
  }

  Future<void> removeItemByVariant({
    required String userId,
    required int productVariantId,
  }) async {
    final cart = await getOrCreateCart(userId: userId);

    await _supabaseClient
        .from('cart_item')
        .delete()
        .eq('cart_id', cart['id'])
        .eq('product_variant_id', productVariantId);
  }

  Future<void> clearCart({required String userId}) async {
    final cart = await getOrCreateCart(userId: userId);
    await _supabaseClient.from('cart_item').delete().eq('cart_id', cart['id']);
  }
}

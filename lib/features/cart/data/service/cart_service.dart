import 'package:coffee_app/core/services/app_locale.dart';
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
        products(
          *,
          products_translation!inner(name, description),
          product_variants(id,quantity,price,product_id,size_${AppLocale.current.languageCode}),
          categories(id, name_${AppLocale.current.languageCode})
        )
      ''') // Removed comma after categories
        .eq('cart_id', cart['id'])
        .eq(
          'products.products_translation.language_code',
          AppLocale.current.languageCode,
        )
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>> addToCart({
    required String userId,
    required int productId,
    required int selectedVariantIndex,
    int quantity = 1,
  }) async {
    final cart = await getOrCreateCart(userId: userId);

    final existing = await _supabaseClient
        .from('cart_item')
        .select()
        .eq('cart_id', cart['id'])
        .eq('product_id', productId)
        .eq('variant_index', selectedVariantIndex)
        .maybeSingle();

    if (existing != null) {
      final newQty = (existing['quantity'] as int) + quantity;
      return await updateQuantityById(
        cartItemId: existing['id'] as int,
        newQuantity: newQty,
      );
    } else {
      final inserted = await _supabaseClient
          .from('cart_item')
          .insert({
            'cart_id': cart['id'],
            'product_id': productId,
            'variant_index': selectedVariantIndex,
            'quantity': quantity,
            'created_at': DateTime.now().toIso8601String(),
          })
          .select('id')
          .single();
      final cartItemId = inserted['id'];

      final newItem = await _supabaseClient
          .from('cart_item')
          .select('''
            *,
            products(
              *,
              products_translation!inner(name, description),
              categories(id, name_${AppLocale.current.languageCode}),
              product_variants(*)
            )
          ''')
          .eq('id', cartItemId)
          .eq(
            'products.products_translation.language_code',
            AppLocale.current.languageCode,
          )
          .single();

      return newItem;
    }
  }

  Future<Map<String, dynamic>> updateQuantity({
    required String userId,
    required int cartItemId,
    required int newQuantity,
  }) async {
    await _supabaseClient
        .from('cart_item')
        .update({'quantity': newQuantity})
        .eq('id', cartItemId);

    final updated = await _supabaseClient
        .from('cart_item')
        .select('''
          *,
          products(
            *,
            products_translation!inner(name, description),
            categories(id, name_${AppLocale.current.languageCode}),
            product_variants(*)
          )
        ''')
        .eq('id', cartItemId)
        .eq(
          'products.products_translation.language_code',
          AppLocale.current.languageCode,
        )
        .single();

    return updated;
  }

  Future<Map<String, dynamic>> updateQuantityById({
    required int cartItemId,
    required int newQuantity,
  }) async {
    await _supabaseClient
        .from('cart_item')
        .update({'quantity': newQuantity})
        .eq('id', cartItemId);

    final updated = await _supabaseClient
        .from('cart_item')
        .select('''
          *,
          products(
            *,
            products_translation!inner(name, description),
            categories(id, name_${AppLocale.current.languageCode}),
            product_variants(*)
          )
        ''')
        .eq('id', cartItemId)
        .eq(
          'products.products_translation.language_code',
          AppLocale.current.languageCode,
        )
        .single();

    return updated;
  }

  Future<void> removeItemById({required int cartItemId}) async {
    await _supabaseClient.from('cart_item').delete().eq('id', cartItemId);
  }

  Future<void> clearCart({required String userId}) async {
    final cart = await getOrCreateCart(userId: userId);
    await _supabaseClient.from('cart_item').delete().eq('cart_id', cart['id']);
  }
}

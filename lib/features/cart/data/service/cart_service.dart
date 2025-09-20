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
          product_variants(
            *,
            products(
              *,
              products_translation!inner(name, description),
              categories(id, name_${AppLocale.current.languageCode})
            )
          )
        ''')
        .eq('cart_id', cart['id'])
        .eq(
          'product_variants.products.products_translation.language_code',
          AppLocale.current.languageCode,
        )
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>> addToCart({
    required String userId,
    required int productId,
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
      return await updateQuantityById(
        cartItemId: existing['id'] as int,
        newQuantity: newQty,
      );
    } else {
      final inserted = await _supabaseClient
          .from('cart_item')
          .insert({
            'cart_id': cart['id'],
            'product_variant_id': productVariantId,
            'quantity': quantity,
            'created_at': DateTime.now().toIso8601String(),
            'product_id': productId,
          })
          .select('id')
          .single();

      final cartItemId = inserted['id'];

      final newItem = await _supabaseClient
          .from('cart_item')
          .select('''
          *,
          product_variants(
            *,
            products(
              *,
              products_translation!inner(name, description),
              categories(id, name_${AppLocale.current.languageCode})
            )
          )
        ''')
          .eq('id', cartItemId)
          .eq(
            'product_variants.products.products_translation.language_code',
            AppLocale.current.languageCode,
          )
          .single();

      return newItem;
    }
  }

  Future<Map<String, dynamic>> updateQuantity({
    required String userId,
    required int productVariantId,
    required int newQuantity,
  }) async {
    final cart = await getOrCreateCart(userId: userId);

    // First update
    await _supabaseClient
        .from('cart_item')
        .update({'quantity': newQuantity})
        .eq('cart_id', cart['id'])
        .eq('product_variant_id', productVariantId);

    // Then fetch with localization
    final updated = await _supabaseClient
        .from('cart_item')
        .select('''
        *,
        product_variants(
          *,
          products(
            *,
            products_translation!inner(name, description),
            categories(id, name_${AppLocale.current.languageCode})
          )
        )
      ''')
        .eq('cart_id', cart['id'])
        .eq('product_variant_id', productVariantId)
        .eq(
          'product_variants.products.products_translation.language_code',
          AppLocale.current.languageCode,
        )
        .single();

    return updated;
  }

  Future<Map<String, dynamic>> updateQuantityById({
    required int cartItemId,
    required int newQuantity,
  }) async {
    // First, just update
    await _supabaseClient
        .from('cart_item')
        .update({'quantity': newQuantity})
        .eq('id', cartItemId);

    // Then, fetch with localization
    final updated = await _supabaseClient
        .from('cart_item')
        .select('''
        *,
        product_variants(
          *,
          products(
            *,
            products_translation!inner(name, description),
            categories(id, name_${AppLocale.current.languageCode})
          )
        )
      ''')
        .eq('id', cartItemId)
        .eq(
          'product_variants.products.products_translation.language_code',
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

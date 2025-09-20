import 'package:coffee_app/core/services/app_locale.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getFavoriteProducts({
    required String userId,
  }) async {
    final response = await _supabaseClient
        .from("favorites")
        .select('''
          products(
            *,
            products_translation!inner(name, description),
            product_variants(id,quantity,price,product_id,size_${AppLocale.current.languageCode}),
            categories(id,name_${AppLocale.current.languageCode})
          )
        ''')
        .eq('user_id', userId)
        .eq(
          'products.products_translation.language_code',
          AppLocale.current.languageCode,
        )
        .order('created_at', ascending: false);
    return (response as List)
        .map<Map<String, dynamic>>((row) => row['products'])
        .toList();
  }

  Future<void> addToWishlist({
    required int productId,
    required String userId,
  }) async {
    await _supabaseClient.from("favorites").insert({
      'product_id': productId,
      'user_id': userId,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<bool> isProductInWishlist({
    required int productId,
    required String userId,
  }) async {
    final response = await _supabaseClient
        .from("favorites")
        .select("id")
        .eq('product_id', productId)
        .eq('user_id', userId)
        .maybeSingle();

    return response != null;
  }

  Future<void> removeByProductId({
    required int productId,
    required String userId,
  }) async {
    await _supabaseClient
        .from("favorites")
        .delete()
        .eq('product_id', productId)
        .eq('user_id', userId);
  }

  Future<void> removeAll(String userId) async {
    await _supabaseClient.from('favorites').delete().eq('user_id', userId);
  }
}

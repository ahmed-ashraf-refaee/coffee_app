import 'package:supabase_flutter/supabase_flutter.dart';

class WishlistService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  Future<List<Map<String, dynamic>>> getFavouriteProducts({
    required String userId,
  }) async {
    final response = await _supabaseClient
        .from("favorites")
        .select('''
        products(
          *,
          product_variants(*),
          categories(*)
        )
      ''')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map<Map<String, dynamic>>((row) => row['products'])
        .toList();
  }

  Future<void> addToWishlist({
    required int productId,
    required String userId,
  }) async {
    print("==========addToWishlist=========");
    await _supabaseClient.from("favorites").insert({
      'product_id': productId,
      'user_id': userId,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  isProductInWishlist({required int productId}) {
    print("==========isProductInWishlist=========");
    return _supabaseClient
        .from("favorites")
        .select()
        .eq('product_id', productId);
  }

  Future<void> removeByProductId({required int productId}) async {
    print("==========removeByProductId=========");
    await _supabaseClient
        .from("favorites")
        .delete()
        .eq('product_id', productId);
    print("==========removeByProductId done=========");
  }

  Future removeAll() async {
    await _supabaseClient.from('favorites').delete().neq('id', 0);
  }
}

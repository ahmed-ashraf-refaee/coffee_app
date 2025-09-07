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
}

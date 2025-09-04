import 'package:supabase_flutter/supabase_flutter.dart';

class HomeService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await _supabaseClient.from("products").select('''
            *,
            product_variants(*),
            categories(*)
          ''');
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>?> getProductById(int productId) async {
    final response = await _supabaseClient
        .from("products")
        .select('''
            *,
            product_variants(*),
            categories(*)
          ''')
        .eq('id', productId)
        .single();

    return response;
  }

  Future<List<Map<String, dynamic>>> getProductsByCategory(
    int categoryId,
  ) async {
    final response = await _supabaseClient
        .from("products")
        .select('''
            *,
            product_variants(*),
            categories(*)
          ''')
        .eq('category_id', categoryId);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getTop5RatedProducts() async {
    final response = await _supabaseClient
        .from("products")
        .select('''
          *,
          product_variants(*),
          categories(*)
        ''')
        .order('rating', ascending: false)
        .limit(5);

    return List<Map<String, dynamic>>.from(response);
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await _supabaseClient.from("categories").select();
    return List<Map<String, dynamic>>.from(response);
  }
}

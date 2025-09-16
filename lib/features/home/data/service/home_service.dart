import 'package:coffee_app/core/services/app_locale.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await _supabaseClient
        .from("products")
        .select('''
          *,
          products_translation!inner(name, description),
          product_variants(id,quantity,price,product_id,size_${AppLocale.current.languageCode}),
          categories(id,name_${AppLocale.current.languageCode})
      ''')
        .eq(
          'products_translation.language_code',
          AppLocale.current.languageCode,
        );
    return List<Map<String, dynamic>>.from(response);
  }

  Future<Map<String, dynamic>?> getProductById(int productId) async {
    final response = await _supabaseClient
        .from("products")
        .select('''
            *,
            product_variants(*),
            categories(id,name_${AppLocale.current.languageCode})
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
    final response = await _supabaseClient
        .from("categories")
        .select('id, name_${AppLocale.current.languageCode}')
        .order("id", ascending: true);
    return List<Map<String, dynamic>>.from(response);
  }
}

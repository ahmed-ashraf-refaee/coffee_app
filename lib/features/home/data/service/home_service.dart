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

  Future<List<Map<String, dynamic>>> getTop5RatedProducts() async {
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
        )
        .order('discount', ascending: true)
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

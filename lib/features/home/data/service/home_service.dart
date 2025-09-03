import 'package:supabase_flutter/supabase_flutter.dart';

class HomeService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  // Fetch all products with relations
  Future<List<Map<String, dynamic>>> getProducts() async {
    try {
      final response = await _supabaseClient.from("products").select('''
            *,
            product_variants(*),
            categories(*)
          ''');

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Fetch a single product by ID with relations
  Future<Map<String, dynamic>?> getProductById(int productId) async {
    try {
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
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }

  // Fetch a single product by category
  Future<List<Map<String, dynamic>>> getProductsByCategory(
    int categoryId,
  ) async {
    try {
      final response = await _supabaseClient
          .from("products")
          .select('''
            *,
            product_variants(*),
            categories(*)
          ''')
          .eq('category_id', categoryId);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error fetching products by category: $e');
      return [];
    }
  }

  // Alternative: Fetch product with specific variant information
  Future<Map<String, dynamic>?> getProductWithVariants(int productId) async {
    try {
      final response = await _supabaseClient
          .from("products")
          .select('''
            id,
            name,
            description,
            discount,
            rating,
            category_id,
            image_url,
            product_variants(
              id,
              size,
              quantity,
              price,
              product_id
            ),
            categories(
              id,
              name
            )
          ''')
          .eq('id', productId)
          .single();

      return response;
    } catch (e) {
      print('Error fetching product with variants: $e');
      return null;
    }
  }
}

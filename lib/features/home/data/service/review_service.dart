import 'package:supabase_flutter/supabase_flutter.dart';

class ReviewService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getReviewsByProduct(int productId) async {
    final response = await _client
        .from('reviews')
        .select('*, users(first_name, last_name, profile_image_url)')
        .eq('product_id', productId)
        .order('created_at', ascending: false);
    return (response as List).cast<Map<String, dynamic>>();
  }

  Future<void> addReview({
    required int productId,
    required String userId,
    required double rating,
    required String comment,
  }) async {
    await _client.from('reviews').insert({
      'product_id': productId,
      'user_id': userId,
      'rating': rating,
      'comment': comment,
    });
  }
}

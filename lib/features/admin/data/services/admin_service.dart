import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:coffee_app/core/model/product_model.dart';

class AdminProductService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> createProduct(
    ProductModel product, [
    String languageCode = 'en',
  ]) async {
    final response = await _supabase
        .from('products')
        .insert({
          'category_id': product.categoryId,
          'image_url': product.imageUrl,
          'discount': product.discount,
          'rating': product.rating,
          'created_at': DateTime.now().toIso8601String(),
        })
        .select('id')
        .single();

    final productId = response['id'] as int;

    await _supabase.from('products_translation').insert({
      'product_id': productId,
      'language_code': languageCode,
      'name': product.name,
      'description': product.description,
    });

    for (final variant in product.productVariants) {
      await _supabase.from('product_variants').insert({
        'product_id': productId,
        'size_en': variant.size,
        'price': variant.price,
        'quantity': variant.quantity,
      });
    }
  }

  Future<void> updateProduct(
    ProductModel product, [
    String languageCode = 'en',
  ]) async {
    await _supabase
        .from('products')
        .update({
          'category_id': product.categoryId,
          'image_url': product.imageUrl,
          'discount': product.discount,
          'rating': product.rating,
        })
        .eq('id', product.id);

    final existingTranslation = await _supabase
        .from('products_translation')
        .select()
        .eq('product_id', product.id)
        .eq('language_code', languageCode);

    if (existingTranslation.isNotEmpty) {
      await _supabase
          .from('products_translation')
          .update({'name': product.name, 'description': product.description})
          .eq('product_id', product.id)
          .eq('language_code', languageCode);
    } else {
      await _supabase.from('products_translation').insert({
        'product_id': product.id,
        'language_code': languageCode,
        'name': product.name,
        'description': product.description,
      });
    }

    for (final variant in product.productVariants) {
      if (variant.id == 0) {
        await _supabase.from('product_variants').insert({
          'product_id': product.id,
          'size_en': variant.size,
          'price': variant.price,
          'quantity': variant.quantity,
        });
      } else {
        await _supabase
            .from('product_variants')
            .update({
              'size_en': variant.size,
              'price': variant.price,
              'quantity': variant.quantity,
            })
            .eq('id', variant.id);
      }
    }
  }
}

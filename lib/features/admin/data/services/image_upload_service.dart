import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ImageUploadService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> uploadProductImage(File imageFile) async {
    // Generate a unique name for the image
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${const Uuid().v4()}.$fileExt';
    final filePath = 'products/$fileName';

    // Upload to the "product-images" bucket
    await _supabase.storage.from('product-images').upload(filePath, imageFile);

    // Get public URL
    final publicUrl = _supabase.storage
        .from('product-images')
        .getPublicUrl(filePath);

    return publicUrl;
  }
}

import 'package:coffee_app/core/model/categories_model.dart';
import 'package:coffee_app/core/model/product_variants_model.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final double discount;
  final double rating;
  final int numberOfRatings;
  final int categoryId;
  final String imageUrl;
  final DateTime createdAt;
  final List<ProductVariantsModel> productVariants;
  final CategoriesModel? category;
  ProductModel({
    required this.createdAt,
    required this.id,
    required this.name,
    required this.description,
    required this.discount,
    required this.rating,
    required this.numberOfRatings,
    required this.categoryId,
    required this.imageUrl,
    required this.productVariants,
    required this.category,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var variantsList = json['product_variants'] as List;
    List<ProductVariantsModel> productVariantsList = variantsList
        .map((variant) => ProductVariantsModel.fromJson(variant))
        .toList();
    final translation = (json['products_translation'] as List).first;
    return ProductModel(
      id: json['id'] as int,
      name: translation['name'] as String,
      description: translation['description'] as String,
      discount: (json['discount'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      numberOfRatings: json['num_ratings'] as int,
      categoryId: json['category_id'],
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now()),
      productVariants: productVariantsList,
      category: json['categories'] != null
          ? CategoriesModel.fromJson(json['categories'])
          : null,
    );
  }
}

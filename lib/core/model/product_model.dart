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
    final variantsList = (json['product_variants'] as List?) ?? [];
    final productVariantsList = variantsList
        .map((variant) => ProductVariantsModel.fromJson(variant))
        .toList();

    final translationList = (json['products_translation'] as List?) ?? [];
    final translation =
        translationList.isNotEmpty ? translationList.first : {};

    return ProductModel(
      id: json['id'] as int,
      name: translation['name'] ?? '',
      description: translation['description'] ?? '',
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      numberOfRatings: json['num_ratings'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      createdAt:
          DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      productVariants: productVariantsList,
      category: json['categories'] != null
          ? CategoriesModel.fromJson(json['categories'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'discount': discount,
      'rating': rating,
      'num_ratings': numberOfRatings,
      'category_id': categoryId,
      'image_url': imageUrl,
      'created_at': createdAt.toIso8601String(),
      'product_variants':
          productVariants.map((variant) => variant.toJson()).toList(),
      if (category != null) 'categories': category!.toJson(),
      'products_translation': [
        {'name': name, 'description': description}
      ],
    };
  }
}

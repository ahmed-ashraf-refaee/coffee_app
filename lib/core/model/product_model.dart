import 'package:coffee_app/core/model/categories_model.dart';
import 'package:coffee_app/core/model/product_variants_model.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final double discount;
  final double rating;
  final int categoryId;
  final String imageUrl;
  final List<ProductVariantsModel> productVariants;
  final CategoriesModel category;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.discount,
    required this.rating,
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

    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      discount: (json['discount'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      categoryId: json['category_id'],
      imageUrl: json['image_url'],
      productVariants: productVariantsList,
      category: CategoriesModel.fromJson(json['categories']),
    );
  }
}

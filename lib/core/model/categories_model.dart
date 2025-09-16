import 'package:coffee_app/core/services/app_locale.dart';

class CategoriesModel {
  final int id;
  final String name;
  CategoriesModel({required this.id, required this.name});
  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'] as int,
      name: json['name_${AppLocale.current.languageCode}'] as String,
    );
  }
}

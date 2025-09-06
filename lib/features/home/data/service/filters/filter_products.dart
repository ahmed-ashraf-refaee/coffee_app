import 'package:coffee_app/features/home/data/model/product_model.dart';
import 'package:coffee_app/features/home/data/service/filters/filter_strategy.dart';

class FilterProducts {
  final List<FilterStrategy> strategies;

  FilterProducts({required this.strategies});

  List<ProductModel> apply(List<ProductModel> products) {
    List<ProductModel> filtered = products;
    for (FilterStrategy strategy in strategies) {
      filtered = strategy.filter(filtered);
    }
    return filtered;
  }
}

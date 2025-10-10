class AnalysisDataModel {
  final double revenue;
  final double revenueChange;
  final int customers;
  final double customersChange;
  final int productsSold;
  final double productsChange;
  final double growth;
  final double growthChange;
  final List<SalesTrendPoint> salesTrend;
  final List<CategoryRevenue> topCategories;

  AnalysisDataModel({
    required this.revenue,
    required this.revenueChange,
    required this.customers,
    required this.customersChange,
    required this.productsSold,

    required this.productsChange,
    required this.salesTrend,
    required this.topCategories,
    required this.growth,
    required this.growthChange,
  });
}

class SalesTrendPoint {
  final int month;
  final double revenue;

  SalesTrendPoint({required this.month, required this.revenue});
}

class CategoryRevenue {
  final String category;
  final double revenue;
  final double percentage;

  CategoryRevenue({
    required this.category,
    required this.revenue,
    required this.percentage,
  });
}

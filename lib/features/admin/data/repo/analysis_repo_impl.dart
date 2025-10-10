import 'package:coffee_app/core/errors/error_handler.dart';
import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/admin/data/model/analysis_data_model.dart';
import 'package:coffee_app/features/admin/data/repo/analysis_repo.dart';
import 'package:coffee_app/features/admin/data/service/analysis_service.dart';
import 'package:dartz/dartz.dart';

class AnalysisRepoImpl extends AnalysisRepo {
  AnalysisRepoImpl();
  final service = AnalysisService();

  @override
  Future<Either<Failure, AnalysisDataModel>> fetchDashboardAnalysis() {
    return guard(() async {
      final data = await service.fetchDashboardStats();
      final trend = await service.fetchSalesTrend();
      final topCats = await service.fetchTopCategories();

      return AnalysisDataModel(
        revenue: (data['revenue'] as num?)?.toDouble() ?? 0,
        revenueChange: (data['revenue_change'] as num?)?.toDouble() ?? 0,
        customers: data['customers'] ?? 0,
        customersChange: (data['customers_change'] as num?)?.toDouble() ?? 0,
        productsSold: data['products_sold'] ?? 0,
        productsChange: (data['products_change'] as num?)?.toDouble() ?? 0,
        growth: (data['growth'] as num?)?.toDouble() ?? 0,
        growthChange: (data['growth_change'] as num?)?.toDouble() ?? 0,
        salesTrend: trend
            .map(
              (row) => SalesTrendPoint(
                month: row['index'],
                revenue: (row['revenue'] as num).toDouble(),
              ),
            )
            .toList(),
        topCategories: topCats
            .map(
              (row) => CategoryRevenue(
                category: row['category'],
                revenue: (row['revenue'] as num).toDouble(),
                percentage: (row['percentage'] as num).toDouble(),
              ),
            )
            .toList(),
      );
    });
  }
}

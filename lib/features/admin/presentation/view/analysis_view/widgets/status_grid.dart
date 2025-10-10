import 'package:coffee_app/features/admin/data/model/analysis_data_model.dart';
import 'package:coffee_app/features/admin/presentation/manager/analysis_cubit/analysis_cubit.dart';
import 'package:coffee_app/features/admin/presentation/view/analysis_view/widgets/status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class StatusGrid extends StatelessWidget {
  const StatusGrid({super.key, required this.analysisData});
  final AnalysisDataModel analysisData;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      builder: (context, state) {
        return GridView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          children: [
            StatusCard(
              title: 'Revenue',
              icon: Ionicons.cash_outline,
              change: analysisData.revenueChange,
              value: analysisData.revenue,
              type: StatusType.money,
            ),
            StatusCard(
              title: 'Customers',
              icon: Ionicons.people_outline,
              change: analysisData.customersChange,
              value: analysisData.customers,
              type: StatusType.count,
            ),
            StatusCard(
              title: 'Products Sold',
              icon: Ionicons.bag_handle_outline,
              change: analysisData.productsChange,
              value: analysisData.productsSold,
              type: StatusType.count,
            ),
            StatusCard(
              title: 'Growth',
              icon: Ionicons.trending_up_outline,
              change: analysisData.growthChange,
              value: analysisData.growth,
              type: StatusType.percentage,
            ),
          ],
        );
      },
    );
  }
}

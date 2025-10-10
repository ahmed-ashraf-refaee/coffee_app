import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/features/admin/presentation/manager/analysis_cubit/analysis_cubit.dart';
import 'package:coffee_app/features/admin/presentation/view/analysis_view/widgets/analysis_loading_screen.dart';
import 'package:coffee_app/features/admin/presentation/view/analysis_view/widgets/sales_trend.dart';
import 'package:coffee_app/features/admin/presentation/view/analysis_view/widgets/status_grid.dart';
import 'package:coffee_app/features/admin/presentation/view/analysis_view/widgets/top_categories.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnalysisView extends StatelessWidget {
  const AnalysisView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 16,
            children: [
              BlocBuilder<AnalysisCubit, AnalysisState>(
                builder: (context, state) {
                  if (state is AnalysisLoading) {
                    return const AnalysisLoadingScreen();
                  } else if (state is AnalysisLoaded) {
                    final analysisData = state.data;
                    return Column(
                      spacing: 16,
                      children: [
                        StatusGrid(analysisData: analysisData),
                        SalesTrend(salesTrend: analysisData.salesTrend),
                        TopCategories(
                          topCategories: analysisData.topCategories,
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        S.current.unexpectedError,
                        style: TextStyles.medium20,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

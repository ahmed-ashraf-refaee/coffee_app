import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/title_subtitle.dart';
import 'package:coffee_app/features/admin/presentation/manager/analysis_cubit/analysis_cubit.dart';
import 'package:coffee_app/features/admin/presentation/view/analysis_view/widgets/analysis_loading_screen.dart';
import 'package:coffee_app/features/admin/presentation/view/analysis_view/widgets/sales_trend.dart';
import 'package:coffee_app/features/admin/presentation/view/analysis_view/widgets/status_grid.dart';
import 'package:coffee_app/features/admin/presentation/view/analysis_view/widgets/top_categories.dart';
import 'package:coffee_app/features/navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key});

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AnalysisCubit>().getDashboardAnalysis();
  }

  void _refreshAnalysis() {
    context.read<AnalysisCubit>().getDashboardAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            CustomAppBar(
              leading: CustomIconButton(
                padding: 8,
                onPressed: () =>
                    context.read<AppNavigatorCubit>().setCurrentIndex(0),
                child: Icon(
                  Ionicons.chevron_back,
                  color: context.colors.onSecondary,
                ),
              ),
              trailing: CustomIconButton(
                padding: 8,
                onPressed: _refreshAnalysis,
                child: Icon(
                  Ionicons.refresh_outline,
                  color: context.colors.primary,
                ),
              ),
            ),
            TitleSubtitle(
              title: S.current.analysisTitle,
              subtitle: S.current.analysisSubtitle,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<AnalysisCubit, AnalysisState>(
                  builder: (context, state) {
                    if (state is AnalysisLoading) {
                      return const AnalysisLoadingScreen();
                    } else if (state is AnalysisLoaded) {
                      final analysisData = state.data;
                      return Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}

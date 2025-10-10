import 'package:coffee_app/core/constants/analysis_constants.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/admin/data/model/analysis_data_model.dart';
import 'package:coffee_app/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key, required this.topCategories});
  final List<CategoryRevenue> topCategories;

  @override
  Widget build(BuildContext context) {
    final totalRevenue = topCategories.fold<double>(
      0,
      (sum, item) => sum + (item.revenue),
    );

    final colors = AnalysisConstants.colors(context);

    return PrettierTap(
      shrink: 1,
      onPressed: () {},
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            textDirection: context.isArabic
                ? TextDirection.rtl
                : TextDirection.ltr,
            spacing: 16,
            children: [
              Text(
                'Top Categories',
                style: TextStyles.bold16.copyWith(
                  color: context.colors.onSecondary,
                ),
              ),
              Expanded(
                child: Row(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 2,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 4,
                          centerSpaceRadius: 40,
                          startDegreeOffset: -90,
                          sections: List.generate(topCategories.length, (i) {
                            final cat = topCategories[i];
                            final double percent = totalRevenue == 0
                                ? 0
                                : (cat.revenue / totalRevenue) * 100;
                            return PieChartSectionData(
                              color: colors[i % colors.length],
                              value: percent,
                              title: '${percent.toStringAsFixed(1)}%',
                              radius: 60,
                              titleStyle: TextStyles.regular12.copyWith(
                                color: context.colors.onPrimary,
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 8,
                        children: List.generate(
                          topCategories.length,
                          (i) => _categoryLabel(
                            topCategories[i].category,
                            colors[i % colors.length],
                            context,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryLabel(String label, Color color, BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          // Add this
          child: Text(
            label,
            style: TextStyle(color: context.colors.onSecondary, fontSize: 13),
            overflow: TextOverflow.visible,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

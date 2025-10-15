import 'package:coffee_app/core/constants/analysis_constants.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/admin/data/model/analysis_data_model.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SalesTrend extends StatelessWidget {
  const SalesTrend({super.key, required this.salesTrend});

  final List<SalesTrendPoint> salesTrend;

  @override
  Widget build(BuildContext context) {
    if (salesTrend.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            S.current.noSalesData,
            style: TextStyles.medium16.copyWith(
              color: context.colors.onSecondary,
            ),
          ),
        ),
      );
    }

    // Dynamic axis setup
    final maxRevenue =
        (salesTrend
                    .map((e) => e.revenue)
                    .fold<double>(0, (a, b) => a > b ? a : b) /
                1000)
            .ceilToDouble();
    final yInterval = (maxRevenue / 4).ceilToDouble().clamp(1, double.infinity);
    final xCount = salesTrend.length;
    final xMax = (xCount - 1).toDouble();

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
            spacing: 32,
            children: [
              Text(
                S.current.salesTrend,
                style: TextStyles.bold16.copyWith(
                  color: context.colors.onSecondary,
                ),
              ),
              Expanded(
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: xMax,
                    minY: 0,
                    maxY: maxRevenue == 0 ? 1 : maxRevenue,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      drawHorizontalLine: true,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: context.colors.onSecondary.withValues(
                          alpha: 0.2,
                        ),
                        strokeWidth: 1,
                      ),
                      getDrawingVerticalLine: (value) => FlLine(
                        color: context.colors.onSecondary.withValues(
                          alpha: 0.2,
                        ),
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        left: BorderSide(
                          color: context.colors.surface,
                          width: 3,
                        ),
                        bottom: BorderSide(
                          color: context.colors.surface,
                          width: 3,
                        ),
                      ),
                    ),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 32,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            if (value < 0 || value >= xCount) {
                              return const SizedBox();
                            }
                            return Text(
                              AnalysisConstants.monthOptions[salesTrend[value
                                          .toInt()]
                                      .month -
                                  1],
                              style: TextStyle(
                                color: context.colors.onSecondary,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          interval: yInterval as double,
                          getTitlesWidget: (value, meta) {
                            if (value == 0) return const SizedBox();
                            return Text(
                              '${value.toInt()} ${S.current.abbreviationK}',
                              style: TextStyle(
                                color: context.colors.onSecondary,
                                fontSize: 12,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    lineTouchData: const LineTouchData(enabled: false),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: context.colors.primary,
                        barWidth: 3,
                        dotData: const FlDotData(show: true),
                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              context.colors.primary.withValues(alpha: 0.6),
                              context.colors.primary.withValues(alpha: 0),
                            ],
                          ),
                        ),
                        spots: salesTrend
                            .asMap()
                            .entries
                            .map(
                              (e) => FlSpot(
                                e.key.toDouble(),
                                e.value.revenue / 1000,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

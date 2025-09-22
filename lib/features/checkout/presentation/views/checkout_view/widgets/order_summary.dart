import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/features/cart/presentation/view/widgets/summary_line.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,

      child: Container(
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.colors.secondary,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  S.current.order_summary,
                  style: TextStyles.medium20,
                ),
              ),

              const Expanded(child: Divider()),

              SummaryLine(
                label: S.current.sub_total,
                value: "20",
                style: TextStyles.regular16,
              ),
              SummaryLine(
                label: S.current.shipping,
                value: "20",
                style: TextStyles.regular16,
              ),
              SummaryLine(
                label: S.current.total_price,
                value: "20",
                style: TextStyles.regular16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

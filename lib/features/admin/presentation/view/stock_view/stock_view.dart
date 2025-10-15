import 'package:coffee_app/core/widgets/title_subtitle.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'widgets/stock_app_bar.dart';
import 'widgets/stock_list_body.dart';

class StockView extends StatelessWidget {
  const StockView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StockAppBar(),
            const SizedBox(height: 16),
            TitleSubtitle(
              subtitle: S.current.stockManagerSubtitle,
              title: S.current.stockManagerTitle,
            ),
            const SizedBox(height: 16),
            const Expanded(child: StockListBody()),
          ],
        ),
      ),
    );
  }
}

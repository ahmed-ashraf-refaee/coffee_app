import 'package:flutter/material.dart';

import 'widgets/stock_app_bar.dart';
import 'widgets/stock_list_body.dart';
import 'widgets/stock_view_header.dart';

class StockView extends StatelessWidget {
  const StockView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          children: [
            StockAppBar(),
            SizedBox(height: 16),
            StockHeader(),
            SizedBox(height: 16),
            Expanded(child: StockListBody()),
          ],
        ),
      ),
    );
  }
}

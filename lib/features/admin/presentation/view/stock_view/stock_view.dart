import 'package:flutter/material.dart';

import 'widgets/stock_app_bar.dart';
import 'widgets/stock_list_body.dart';
import 'widgets/stock_view_header.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          StockAppBar(),
          SizedBox(height: 16),
          StockHeader(),
          SizedBox(height: 16),
          Expanded(child: StockListBody()),
        ],
      ),
    );
  }
}

import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/text_styles.dart';
import 'search_and_filter_section.dart';

class StockHeader extends StatefulWidget {
  const StockHeader({super.key});

  @override
  State<StockHeader> createState() => _StockHeaderState();
}

class _StockHeaderState extends State<StockHeader> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Admin Dashboard',
          style: TextStyles.bold20.copyWith(color: context.colors.onSurface),
        ),
        const SizedBox(height: 4),
        Text(
          'Manage your products and stock levels',
          style: TextStyles.regular15.copyWith(
            color: context.colors.onSecondary,
          ),
        ),
        const SizedBox(height: 20),
        SearchAndFilterSection(searchController: _searchController),
      ],
    );
  }
}

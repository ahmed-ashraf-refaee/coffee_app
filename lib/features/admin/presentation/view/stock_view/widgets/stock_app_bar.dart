import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';

/// Extracted widget for the app bar structure
class StockAppBar extends StatelessWidget {
  const StockAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: CustomIconButton(
        padding: 8,
        onPressed: () {
          // Typically handles navigation back
          Navigator.of(context).pop();
        },
        child: Icon(Ionicons.chevron_back, color: context.colors.onSecondary),
      ),
      // Add trailing or other CustomAppBar properties if needed
    );
  }
}

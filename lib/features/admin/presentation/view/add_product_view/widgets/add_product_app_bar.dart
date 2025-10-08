import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';

class AddProductAppBar extends StatelessWidget {
  final VoidCallback onRefresh;

  const AddProductAppBar({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: CustomIconButton(
        padding: 8,
        onPressed: () => Navigator.pop(context),
        child: Icon(Ionicons.chevron_back, color: context.colors.onSecondary),
      ),
      trailing: CustomIconButton(
        padding: 8,
        onPressed: onRefresh,
        child: Icon(Ionicons.refresh_outline, color: context.colors.primary),
      ),
    );
  }
}

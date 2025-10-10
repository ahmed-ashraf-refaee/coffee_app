import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';

/// Extracted widget for the app bar structure
class StockAppBar extends StatelessWidget {
  const StockAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      leading: CustomIconButton(
        padding: 8,
        onPressed: () =>
            BlocProvider.of<AppNavigatorCubit>(context).setCurrentIndex(0),
        child: Icon(Ionicons.chevron_back, color: context.colors.onSecondary),
      ),
    );
  }
}

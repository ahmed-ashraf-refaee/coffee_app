import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';
import 'profile_view_body_settings.dart';
import 'profile_view_info.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CustomAppBar(
                leading: CustomIconButton(
                  padding: 8,
                  onPressed: () => BlocProvider.of<AppNavigatorCubit>(
                    context,
                  ).setCurrentIndex(0),
                  child: Icon(
                    Ionicons.chevron_back,
                    color: context.colors.onSecondary,
                  ),
                ),
              ),
            ),

            const ProfileViewBodyInfoSection(),
            const SizedBox(height: 48),
            const ProfileViewBodySettings(),
          ],
        ),
      ),
    );
  }
}

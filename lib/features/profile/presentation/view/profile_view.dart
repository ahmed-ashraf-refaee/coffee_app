import 'package:coffee_app/features/profile/presentation/manager/setting_cubit/setting_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocProvider(
        create: (context) => SettingCubit(),
        child: const ProfileViewBody(),
      ),
    );
  }
}

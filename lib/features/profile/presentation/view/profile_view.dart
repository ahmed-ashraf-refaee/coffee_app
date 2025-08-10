import 'package:flutter/material.dart';

import 'profile_setting_section.dart';
import 'widgets/profile_app_bar_button.dart';
import 'widgets/profile_info_section.dart';
import 'widgets/profile_support_logout_section.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            ProfileAppBarButton(),
            ProfileInfoSection(),
            SliverToBoxAdapter(child: SizedBox(height: 48)),
            ProfileSettingSection(),
            SliverToBoxAdapter(child: SizedBox(height: 24)),
            ProfileSupportLogoutSection(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../core/utils/color_palette.dart';
import 'widgets/profile_container.dart';
import 'widgets/profile_tile.dart';
import 'widgets/profile_tile_divider.dart';

class ProfileSettingSection extends StatelessWidget {
  const ProfileSettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ProfileGroupContainer(
        child: Column(
          children: [
            ProfileTile(
              prefixIcon: "assets/icons/user_icon.png",
              title: 'Edit Profile',
              suffixWidget: Image.asset(
                "assets/icons/arrow_forward.png",
                height: 24,
                color: ColorPalette.cadetGray,
              ),
            ),
            ProfileTileDivider(),
            ProfileTile(
              prefixIcon: "assets/icons/credit_card.png",
              title: 'Payment Details',
              suffixWidget: Image.asset(
                "assets/icons/arrow_forward.png",
                height: 24,
                color: ColorPalette.cadetGray,
              ),
            ),
            ProfileTileDivider(),
            ProfileTile(
              prefixIcon: "assets/icons/arabic.png",
              title: 'Languages',
              suffixWidget: Image.asset(
                "assets/icons/arrow_forward.png",
                height: 24,
                color: ColorPalette.cadetGray,
              ),
            ),
            ProfileTileDivider(),
            ProfileTile(
              prefixIcon: "assets/icons/bell.png",
              title: 'Notification',
              suffixWidget: SizedBox(
                height: 42,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Switch(value: false, onChanged: (value) {}),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            ProfileTileDivider(),
            ProfileTile(
              prefixIcon: "assets/icons/night_mode.png",
              title: 'Dark Mode',
              suffixWidget: SizedBox(
                height: 42,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Switch(value: true, onChanged: (value) {}),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ],
        ),
      ),
    );
  }
}

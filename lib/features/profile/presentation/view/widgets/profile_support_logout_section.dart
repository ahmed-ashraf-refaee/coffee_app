import 'package:flutter/material.dart';

import '../../../../../core/utils/color_palette.dart';
import 'profile_container.dart';
import 'profile_tile.dart';
import 'profile_tile_divider.dart';

class ProfileSupportLogoutSection extends StatelessWidget {
  const ProfileSupportLogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ProfileGroupContainer(
        child: Column(
          children: [
            ProfileTile(
              prefixIcon: "assets/icons/help.png",
              title: "Support",
              suffixWidget: Image.asset(
                "assets/icons/arrow_forward.png",
                height: 24,
                color: ColorPalette.cadetGray,
              ),
            ),
            const ProfileTileDivider(),
            ProfileTile(
              title: "Logout",
              suffixWidget: Image.asset(
                "assets/icons/logout.png",
                height: 24,
                color: ColorPalette.orangeCrayola,
              ),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
            ),
          ],
        ),
      ),
    );
  }
}

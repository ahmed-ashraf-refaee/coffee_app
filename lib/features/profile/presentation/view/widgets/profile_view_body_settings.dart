import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/widgets/prettier_tap.dart';
import '../../../../../generated/l10n.dart';
import 'profile_container.dart';
import 'profile_tile.dart';

class ProfileViewBodySettings extends StatelessWidget {
  const ProfileViewBodySettings({super.key});

  @override
  Widget build(BuildContext context) {
    Icon arrowIcon() {
      if (context.isArabic) {
        return Icon(Ionicons.chevron_back, color: context.colors.onSecondary);
      }
      return Icon(Ionicons.chevron_forward, color: context.colors.onSecondary);
    }

    return Column(
      children: [
        ProfileGroupContainer(
          child: Column(
            children: [
              PrettierTap(
                shrink: 1,
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/user_icon.png",
                  title: S.current.profile_edit_profile,
                  suffixWidget: arrowIcon(),
                ),
              ),
              _profileTileDivider(),
              PrettierTap(
                shrink: 1,
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/credit_card.png",
                  title: S.current.profile_payment_details,
                  suffixWidget: arrowIcon(),
                ),
              ),
              _profileTileDivider(),
              PrettierTap(
                shrink: 1,
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/arabic.png",
                  title: S.current.profile_languages,
                  suffixWidget: arrowIcon(),
                ),
              ),
              _profileTileDivider(),
              ProfileTile(
                prefixIcon: "assets/icons/bell.png",
                title: S.current.profile_notification,
                suffixWidget: SizedBox(
                  height: 42,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Switch(value: false, onChanged: (value) {}),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              _profileTileDivider(),
              ProfileTile(
                prefixIcon: "assets/icons/night_mode.png",
                title: S.current.profile_dark_mode,
                suffixWidget: SizedBox(
                  height: 42,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Switch(value: true, onChanged: (value) {}),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ProfileGroupContainer(
          child: Column(
            children: [
              PrettierTap(
                shrink: 1,
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/help.png",
                  title: S.current.profile_support,
                  suffixWidget: arrowIcon(),
                ),
              ),
              _profileTileDivider(),
              PrettierTap(
                shrink: 1,
                onPressed: () {},
                child: ProfileTile(
                  title: S.current.profile_logout,
                  suffixWidget: Icon(
                    Ionicons.log_out_outline,
                    color: context.colors.onSecondary,
                    size: 32,
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 22),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Divider _profileTileDivider() {
    return Divider(
      color: const Color(0xff5D6165).withAlpha((85 * 255 / 100).toInt()),
      indent: 16,
      endIndent: 16,
      thickness: 1,
    );
  }
}

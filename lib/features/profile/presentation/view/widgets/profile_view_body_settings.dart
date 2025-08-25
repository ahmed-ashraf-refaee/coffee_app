import 'package:coffee_app/features/profile/presentation/manager/toggle_to_darkmode/toggle_to_darkmode_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/widgets/prettier_tap.dart';
import '../../../../../generated/l10n.dart';
import 'profile_container.dart';
import 'profile_tile.dart';

class ProfileViewBodySettings extends StatelessWidget {
  const ProfileViewBodySettings({super.key});

  @override
  Widget build(BuildContext context) {
    Icon arrowIcon = Icon(
      context.isArabic
          ? Ionicons.chevron_back_outline
          : Ionicons.chevron_forward_outline,
      color: context.colors.onSecondary.withAlpha(220),
    );
    return Column(
      children: [
        ProfileGroupContainer(
          child: Column(
            children: [
              PrettierTap(
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/user_icon.png",
                  title: S.current.profile_edit_profile,
                  suffixWidget: arrowIcon,
                ),
              ),
              _profileTileDivider(),
              PrettierTap(
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/credit_card.png",
                  title: S.current.profile_payment_details,
                  suffixWidget: arrowIcon,
                ),
              ),
              _profileTileDivider(),
              PrettierTap(
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/arabic.png",
                  title: S.current.profile_languages,
                  suffixWidget: arrowIcon,
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
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  final isDark = themeMode == ThemeMode.dark;

                  return ProfileTile(
                    prefixIcon: "assets/icons/night_mode.png",
                    title: S.current.profile_dark_mode,
                    suffixWidget: SizedBox(
                      height: 42,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Switch(
                          value: isDark,
                          onChanged: (value) {
                            context.read<ThemeCubit>().toggleTheme();
                          },
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ProfileGroupContainer(
          child: Column(
            children: [
              PrettierTap(
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/help.png",
                  title: S.current.profile_support,
                  suffixWidget: arrowIcon,
                ),
              ),
              _profileTileDivider(),
              PrettierTap(
                onPressed: () {},
                child: ProfileTile(
                  title: S.current.profile_logout,
                  suffixWidget: Image.asset(
                    "assets/icons/logout.png",
                    height: 24,
                    color: context.colors.primary,
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

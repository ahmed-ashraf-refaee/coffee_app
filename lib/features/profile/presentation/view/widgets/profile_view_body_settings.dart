import 'package:coffee_app/core/constants/language_constants.dart';
import 'package:coffee_app/core/services/app_locale.dart';
import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/features/home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';
import 'package:coffee_app/features/profile/presentation/manager/locale_cubit/locale_cubit.dart';
import 'package:coffee_app/features/profile/presentation/manager/setting_cubit/setting_cubit.dart';
import 'package:coffee_app/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
              _profileTileDivider(context),
              PrettierTap(
                shrink: 1,
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/credit_card.png",
                  title: S.current.profile_payment_details,
                  suffixWidget: arrowIcon(),
                ),
              ),
              _profileTileDivider(context),
              PrettierTap(
                shrink: 1,
                onPressed: () {
                  
                  GoRouter.of(context).push(AppRouter.kLanguageSelect);
                },
                child: ProfileTile(
                  prefixIcon: "assets/icons/arabic.png",
                  title: S.current.profile_languages,
                  suffixWidget: arrowIcon(),
                ),
              ),
              _profileTileDivider(context),
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
              _profileTileDivider(context),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, themeMode) {
                  final brightness = MediaQuery.of(context).platformBrightness;
                  final isDark =
                      themeMode == ThemeMode.dark ||
                      (themeMode == ThemeMode.system &&
                          brightness == Brightness.dark);
                  return PrettierTap(
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                    shrink: 1,
                    child: ProfileTile(
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
                shrink: 1,
                onPressed: () {},
                child: ProfileTile(
                  prefixIcon: "assets/icons/help.png",
                  title: S.current.profile_support,
                  suffixWidget: arrowIcon(),
                ),
              ),
              _profileTileDivider(context),
              PrettierTap(
                shrink: 1,
                onPressed: () async {
                  await BlocProvider.of<SettingCubit>(context).logout();
                  GoRouter.of(context).pushReplacement(AppRouter.kAuthView);
                },
                child: ProfileTile(
                  title: S.current.profile_logout,
                  suffixWidget: Transform.scale(
                    scaleX: context.isArabic ? -1 : 1,
                    child: Icon(
                      Ionicons.log_out_outline,
                      color: context.colors.primary,
                      size: 32,
                    ),
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

  Divider _profileTileDivider(BuildContext context) {
    return Divider(
      color: context.colors.onSecondary.withValues(alpha: 0.85),
      indent: 16,
      endIndent: 16,
      thickness: 1,
    );
  }
}

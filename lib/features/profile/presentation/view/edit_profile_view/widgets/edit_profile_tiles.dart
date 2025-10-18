import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/widgets/prettier_tap.dart';
import '../../../../../../generated/l10n.dart';
import '../../profile_view/widgets/profile_container.dart';
import '../../profile_view/widgets/profile_tile.dart';

class ProfileActionTile extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onPressed;

  const ProfileActionTile({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileContainer(
      child: PrettierTap(
        shrink: 1,
        onPressed: onPressed,
        child: ProfileTile(
          prefixIcon: iconPath,
          title: title,
          suffixWidget: context.isArabic
              ? Icon(Ionicons.chevron_back, color: context.colors.onSecondary)
              : Icon(
                  Ionicons.chevron_forward,
                  color: context.colors.onSecondary,
                ),
        ),
      ),
    );
  }
}

class ChangeEmailTile extends StatelessWidget {
  const ChangeEmailTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileActionTile(
      iconPath: "assets/icons/email.png",
      title: S.current.changeEmail,
      onPressed: () {
        GoRouter.of(context).push(AppRouter.kChangeEmailView);
      },
    );
  }
}

class ChangePasswordTile extends StatelessWidget {
  const ChangePasswordTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileActionTile(
      iconPath: "assets/icons/change_password.png",
      title: S.current.changePassword,
      onPressed: () {
        GoRouter.of(context).push(AppRouter.kChangePassword);
      },
    );
  }
}

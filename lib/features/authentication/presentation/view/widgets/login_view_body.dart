import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/authentication/presentation/view/widgets/Login_form.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

import 'auth_suggestion.dart';
import 'auth_title.dart';
import 'social_button.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key, required this.toggleAuthMode});
  final VoidCallback toggleAuthMode;

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTitle(
          title: S.current.welcome_back_title,
          subtitle: S.current.welcome_back_subtitle,
        ),
        const SizedBox(height: 48),
        const LoginForm(),
        const SizedBox(height: 16),
        Row(
          children: [
            Transform.scale(
              scale: 20 / 24,
              child: Checkbox(
                value: rememberMe,
                onChanged: (value) {
                  setState(() {
                    rememberMe = value!;
                  });
                },
              ),
            ),
            Text(
              S.current.remember_me,
              style: TextStyles.bold14.copyWith(
                color: context.colors.onSecondary,
              ),
            ),
            const Spacer(),
            PrettierTap(
              shrink: 2,
              onPressed: () {},
              child: Text(
                S.current.forgot_password,
                style: TextStyles.bold14.copyWith(
                  color: context.colors.onSecondary.withAlpha(102),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 48),

        CustomElevatedButton(
          onPressed: () {},
          child: Text(S.current.log_in, style: TextStyles.medium20),
        ),

        const SizedBox(height: 58),
        Row(
          spacing: 16,
          children: [
            const Expanded(child: Divider()),
            Text(
              S.current.or,
              style: TextStyles.bold16.copyWith(
                color: context.colors.onSecondary.withAlpha(153),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 58),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 76,
          children: [
            SocialButton(
              onPressed: () {},
              imageAsset: "assets/icons/facebook.png",
              title: S.current.facebook,
            ),
            SocialButton(
              onPressed: () {},
              imageAsset: "assets/icons/google.png",
              title: S.current.google,
            ),
          ],
        ),
        const Spacer(),
        AuthSuggestion(
          toggleAuthMode: widget.toggleAuthMode,
          suggestionText: S.current.dont_have_account,
          actionText: S.current.sign_up,
        ),
      ],
    );
  }
}

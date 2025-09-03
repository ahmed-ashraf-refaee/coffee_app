import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/authentication/presentation/view/widgets/login_form.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../core/helper/ui_helpers.dart';
import '../../manager/auth_bloc/auth_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> rememberMe = ValueNotifier(false);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
        LoginForm(
          formKey: _formKey,
          emailController: emailController,
          passwordController: passwordController,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ValueListenableBuilder(
              valueListenable: rememberMe,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 20 / 24,
                  child: Checkbox(
                    value: rememberMe.value,
                    onChanged: (value) {
                      setState(() {
                        rememberMe.value = value!;
                      });
                    },
                  ),
                );
              },
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

        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              UiHelpers.showSnackBar(context: context, message: state.error);
            }
            if (state is AuthSuccess) {
              UiHelpers.showSnackBar(
                context: context,
                message: "Registered Successfully",
              );
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<AuthBloc>(context).add(
                    LoginEvent(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    ),
                  );
                }
              },
              child: state is AuthLoading
                  ? SpinKitThreeBounce(
                      color: context.colors.onPrimary,
                      size: 26,
                    )
                  : Text(
                      S.current.log_in,
                      style: TextStyles.medium20.copyWith(
                        color: context.colors.onPrimary,
                      ),
                    ),
            );
          },
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

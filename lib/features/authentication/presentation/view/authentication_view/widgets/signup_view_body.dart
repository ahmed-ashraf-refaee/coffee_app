import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:coffee_app/features/authentication/presentation/view/authentication_view/widgets/Signup_form.dart';

import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import 'auth_suggestion.dart';
import '../../widgets/auth_title.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key, required this.toggleAuthMode});
  final VoidCallback toggleAuthMode;

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTitle(
          title: S.current.get_started_title,
          subtitle: S.current.get_started_subtitle,
        ),
        const SizedBox(height: 48),
        SignupForm(
          formKey: _formKey,
          firstNameController: firstNameController,
          lastNameController: lastNameController,
          usernameController: usernameController,
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
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
                message: S.current.registrationSuccess,
                action: SnackBarAction(
                  label: S.current.log_in,
                  onPressed: widget.toggleAuthMode,
                  textColor: context.colors.primary,
                ),
              );
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is AuthLoading,

              onPressed: () {
                if (usernameController.text.trim().isNotEmpty &&
                    usernameController.text.trim().length >= 2) {
                  BlocProvider.of<AuthBloc>(context).add(
                    UsernameCheckEvent(
                      username: usernameController.text.trim(),
                    ),
                  );
                }
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<AuthBloc>(context).add(
                    SignupEvent(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      username: usernameController.text.trim(),
                      firstName: firstNameController.text.trim(),
                      lastName: lastNameController.text.trim(),
                    ),
                  );
                }
              },
              child: Text(
                S.current.sign_up,
                style: TextStyles.medium20.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),
            );
          },
        ),
        const Spacer(),
        AuthSuggestion(
          toggleAuthMode: widget.toggleAuthMode,
          suggestionText: S.current.already_have_account,
          actionText: S.current.log_in,
        ),
      ],
    );
  }
}

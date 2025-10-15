import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/prettier_tap.dart';
import '../../../../../../core/widgets/title_subtitle.dart';
import '../../../../../../main.dart';

class ChangeEmailViewBody extends StatefulWidget {
  const ChangeEmailViewBody({super.key});

  @override
  State<ChangeEmailViewBody> createState() => _ChangeEmailViewBodyState();
}

class _ChangeEmailViewBodyState extends State<ChangeEmailViewBody> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(
            leading: PrettierTap(
              onPressed: () {},
              child: CustomIconButton(
                padding: 8,
                onPressed: () => GoRouter.of(context).pop(),
                child: Icon(
                  context.isArabic
                      ? Ionicons.chevron_forward
                      : Ionicons.chevron_back,
                  color: context.colors.onSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          const TitleSubtitle(
            title: 'Change Email',
            subtitle: 'Change Your Email account.',
          ),
          const SizedBox(height: 48),

          Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'email',
                    prefixIcon: Icon(Ionicons.person_outline),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _isPasswordVisible,
                  builder: (context, value, _) {
                    return TextFormField(
                      controller: passwordController,
                      obscureText: !value,
                      decoration: InputDecoration(
                        hintText: 'password',
                        prefixIcon: const Icon(Ionicons.lock_closed_outline),
                        suffixIcon: IconButton(
                          onPressed: () => _isPasswordVisible.value =
                              !_isPasswordVisible.value,
                          icon: Icon(
                            value ? Ionicons.eye : Ionicons.eye_off_outline,
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          /// --- Update Email Button ---
          // BlocConsumer<AuthBloc, AuthState>(
          //   listener: (context, state) {
          //     if (state is AuthFailure) {
          //       UiHelpers.showSnackBar(
          //         context: context,
          //         message: state.error,
          //       );
          //     } else if (state is AuthUpdateEmailSuccess) {
          //       UiHelpers.showSnackBar(
          //         context: context,
          //         message: 'Email updated successfully!',
          //       );
          //       GoRouter.of(context).pop();
          //     }
          //   },
          //   builder: (context, state) {
          // return
          CustomElevatedButton(
            // isLoading: state is AuthLoading,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // BlocProvider.of<AuthBloc>(context).add(
                //   UpdateEmailEvent(
                //     newEmail: emailController.text.trim(),
                //     password: passwordController.text.trim(),
                //   ),
                // );
              }
            },
            child: const Text('Update Email', style: TextStyles.medium20),
          ),
          // },
          // ),
        ],
      ),
    );
  }
}

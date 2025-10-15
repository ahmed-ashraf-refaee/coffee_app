import 'package:coffee_app/core/constants/reg_constants.dart';
import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/animated_icon_switch.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:coffee_app/features/authentication/presentation/view/authentication_view/widgets/build_suffix_icon_with_divider.dart';
import 'package:coffee_app/core/widgets/title_subtitle.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/helper/ui_helpers.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 58),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleSubtitle(
            title: S.current.setPassword,
            subtitle: S.current.setPasswordSubtitle,
          ),
          const SizedBox(height: 48),
          Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                ValueListenableBuilder(
                  valueListenable: _isPasswordVisible,
                  builder: (context, value, _) {
                    return TextFormField(
                      controller: passwordController,
                      obscureText: !value,
                      decoration: InputDecoration(
                        hintText: S.current.password,
                        prefixIcon: const Icon(Ionicons.lock_closed_outline),
                        suffixIcon: buildSuffixIconWithDivider(
                          context,
                          AnimatedIconSwitch(
                            children: const [
                              Icon(Ionicons.eye_off_outline),
                              Icon(Ionicons.eye),
                            ],
                            onChanged: (value) {
                              _isPasswordVisible.value = value;
                            },
                          ),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return S.current.enterPassword;
                        }
                        if (value.length < 8) {
                          return S.current.minPassword;
                        }
                        if (!RegConstants.passwordRegExp.hasMatch(value)) {
                          return S.current.passwordRequirement;
                        }
                        return null;
                      },
                    );
                  },
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: S.current.confirm_password,
                    prefixIcon: const Icon(Ionicons.lock_closed_outline),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.current.confirmPassword;
                    } else if (value != passwordController.text) {
                      return S.current.passwordsDontMatch;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                UiHelpers.showSnackBar(context: context, message: state.error);
              } else if (state is AuthforgotPasswordSuccess) {
                UiHelpers.showSnackBar(
                  context: context,
                  message: S.current.passwordUpdatedSuccessfully,
                );
                GoRouter.of(context).pushReplacement(AppRouter.kAuthView);
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                isLoading: state is AuthLoading,

                child: Text(
                  S.current.setPasswordButton,
                  style: TextStyles.medium20,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context).add(
                      UpdatePasswordEvent(
                        password: passwordController.text.trim(),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

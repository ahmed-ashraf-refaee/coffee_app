import 'package:coffee_app/core/constants/reg_constants.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helper/ui_helpers.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/prettier_tap.dart';
import '../../../../../../core/widgets/title_subtitle.dart';
import '../../../../../../main.dart';
import '../../../../../authentication/presentation/manager/auth_bloc/auth_bloc.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _isCurrentVisible = ValueNotifier(false);
  final ValueNotifier<bool> _isNewVisible = ValueNotifier(false);

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    _isCurrentVisible.dispose();
    _isNewVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// --- App Bar ---
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

          /// --- Title ---
          const TitleSubtitle(
            title: 'Change Password',
            subtitle: 'Create a new password for your account.',
          ),
          const SizedBox(height: 48),

          /// --- Form ---
          Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                /// Current Password
                ValueListenableBuilder(
                  valueListenable: _isCurrentVisible,
                  builder: (context, value, _) {
                    return TextFormField(
                      controller: currentPasswordController,
                      obscureText: !value,
                      decoration: InputDecoration(
                        hintText: 'current password',
                        prefixIcon: const Icon(Ionicons.lock_closed_outline),
                        suffixIcon: IconButton(
                          onPressed: () => _isCurrentVisible.value =
                              !_isCurrentVisible.value,
                          icon: Icon(
                            value ? Ionicons.eye : Ionicons.eye_off_outline,
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please enter your current password';
                        }
                        return null;
                      },
                    );
                  },
                ),

                /// New Password
                ValueListenableBuilder(
                  valueListenable: _isNewVisible,
                  builder: (context, value, _) {
                    return TextFormField(
                      controller: newPasswordController,
                      obscureText: !value,
                      decoration: InputDecoration(
                        hintText: 'password',
                        prefixIcon: const Icon(Ionicons.lock_closed_outline),
                        suffixIcon: IconButton(
                          onPressed: () =>
                              _isNewVisible.value = !_isNewVisible.value,
                          icon: Icon(
                            value ? Ionicons.eye : Ionicons.eye_off_outline,
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Please enter a new password';
                        }
                        if (v.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        if (!RegConstants.passwordRegExp.hasMatch(v)) {
                          return 'Password must contain letters and numbers';
                        }
                        return null;
                      },
                    );
                  },
                ),

                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'confirm password',
                    prefixIcon: Icon(Ionicons.lock_closed_outline),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (v != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          /// --- Update Password Button ---
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                UiHelpers.showSnackBar(context: context, message: state.error);
              } else if (state is AuthSuccess) {
                UiHelpers.showSnackBar(
                  context: context,
                  message: 'Password updated successfully!',
                );
                GoRouter.of(context).pop();
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                isLoading: state is AuthLoading,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<AuthBloc>(context).add(
                      UpdatePasswordEvent(
                        currentPassword: currentPasswordController.text.trim(),
                        newPassword: newPasswordController.text.trim(),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Update password',
                  style: TextStyles.medium20,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

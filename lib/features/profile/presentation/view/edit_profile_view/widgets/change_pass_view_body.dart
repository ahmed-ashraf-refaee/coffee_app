import 'package:coffee_app/core/constants/reg_constants.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/features/navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helper/ui_helpers.dart';
import '../../../../../../core/utils/app_router.dart';
import '../../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/prettier_tap.dart';
import '../../../../../../core/widgets/title_subtitle.dart';
import '../../../../../../generated/l10n.dart';
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
                  Ionicons.chevron_back,
                  color: context.colors.onSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          /// --- Title ---
          TitleSubtitle(
            title: S.current.resetPassword,
            subtitle: S.current.setPasswordSubtitle,
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
                        hintText: S.current.currentPassword,
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
                          return S.current.enterPassword;
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
                        hintText: S.current.newPassword,
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
                          return S.current.enterPassword;
                        }
                        if (v.length < 8) {
                          return S.current.minPassword;
                        }
                        if (!RegConstants.passwordRegExp.hasMatch(v)) {
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
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return S.current.confirmPassword;
                    }
                    if (v != newPasswordController.text) {
                      return S.current.passwordsDontMatch;
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
                  message: S.current.passwordUpdatedSuccessfully,
                );
                GoRouter.of(context).pushReplacement(AppRouter.kNavigationView);
                context.read<AppNavigatorCubit>().setCurrentIndex(3);
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
                child: Text(
                  S.current.setPasswordButton,
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

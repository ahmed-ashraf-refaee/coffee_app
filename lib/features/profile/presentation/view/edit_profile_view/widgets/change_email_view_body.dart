import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/generated/l10n.dart';
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
import '../../../../../../main.dart';
import '../../../../../authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import '../../../../../navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';
import '../../../manager/edit_profile/edit_profile_cubit.dart';

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

          TitleSubtitle(
            title: S.current.profile_edit_profile,
            subtitle: S.current.email,
          ),
          const SizedBox(height: 48),

          Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: S.current.email,
                    prefixIcon: const Icon(Ionicons.person_outline),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.current.enterEmail;
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                    ).hasMatch(value)) {
                      return S.current.invalidEmail;
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
                        hintText: S.current.password,
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
                          return S.current.enterPassword;
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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                UiHelpers.showSnackBar(context: context, message: state.error);
              } else if (state is AuthSuccess) {
                UiHelpers.showSnackBar(
                  context: context,
                  message: S.current.registrationSuccess,
                );
                context.read<EditProfileCubit>().fetchUserData();

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
                      UpdateEmailEvent(
                        newEmail: emailController.text.trim(),
                        currentPassword: passwordController.text.trim(),
                      ),
                    );
                  }
                },
                child: Text(
                  S.current.updateProduct, // using existing localized key
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

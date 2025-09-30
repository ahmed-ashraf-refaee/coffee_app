// ignore_for_file: file_names
import 'package:coffee_app/core/constants/reg_constants.dart';
import 'package:coffee_app/core/widgets/animated_icon_switch.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'build_suffix_icon_with_divider.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);

  @override
  void dispose() {
    _isPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: widget.emailController,
            decoration: InputDecoration(
              hintText: S.current.email,
              prefixIcon: const Icon(Ionicons.mail_outline),
            ),
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return S.current.enterEmail;
              } else if (!RegConstants.emailRegExp.hasMatch(value.trim())) {
                return S.current.invalidEmail;
              }
              return null;
            },
          ),

          ValueListenableBuilder(
            valueListenable: _isPasswordVisible,
            builder: (context, value, child) {
              return TextFormField(
                controller: widget.passwordController,
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
                  return null;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

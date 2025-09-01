import 'package:coffee_app/core/widgets/animated_icon_switch.dart';
import 'package:coffee_app/features/authentication/presentation/view/widgets/build_suffix_icon_with_divider.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const LoginForm({super.key, required this.formKey});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RegExp _emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
            controller: emailController,
            decoration: InputDecoration(
              hintText: S.current.email,
              prefixIcon: const Icon(Ionicons.mail_outline),
            ),
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return S.current.enterEmail;
              } else if (!_emailRegExp.hasMatch(value.trim())) {
                return S.current.invalidEmail;
              }
              return null;
            },
          ),

          ValueListenableBuilder(
            valueListenable: _isPasswordVisible,
            builder: (context, value, child) {
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

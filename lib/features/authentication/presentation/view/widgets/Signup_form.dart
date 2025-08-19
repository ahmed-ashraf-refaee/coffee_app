import 'package:coffee_app/features/authentication/presentation/view/widgets/build_suffix_icon_with_divider.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/animated_icon_switch.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;

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
    return Form(
      key: _formKey,
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: S.current.first_name,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: S.current.last_name,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: S.current.username,
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: S.current.email,
              prefixIcon: const Icon(Icons.email),
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              hintText: S.current.password,
              prefixIcon: const Icon(Icons.password),
              suffixIcon: buildSuffixIconWithDivider(
                context,
                AnimatedIconSwitch(
                  children: const [
                    Icon(Icons.visibility_off),
                    Icon(Icons.visibility),
                  ],
                  onChanged: (value) {
                    setState(() {
                      isPasswordVisible = value;
                    });
                  },
                ),
              ),
            ),
          ),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: S.current.confirm_password,
              prefixIcon: const Icon(Icons.password),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:coffee_app/core/widgets/Icon_animated_switch.dart';
import 'package:coffee_app/features/authentication/presentation/view/widgets/build_suffix_icon_with_divider.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
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
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              hintText: S.current.username,
              prefixIcon: const Icon(Icons.person),
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
                IconAnimatedSwitch(
                  icons: [
                    const Icon(Icons.visibility_off),
                    const Icon(Icons.visibility),
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
        ],
      ),
    );
  }
}

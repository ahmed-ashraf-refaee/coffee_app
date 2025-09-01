import 'package:coffee_app/core/widgets/gradient_container.dart';
import 'package:coffee_app/features/authentication/presentation/view/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

import 'widgets/signup_view_body.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  bool login = true;
  void toggleAuthMode() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GradientContainer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: login
                    ? LoginViewBody(toggleAuthMode: toggleAuthMode)
                    : SignupViewBody(toggleAuthMode: toggleAuthMode),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

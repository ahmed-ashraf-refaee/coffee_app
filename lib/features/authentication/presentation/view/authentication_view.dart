import 'package:coffee_app/core/widgets/gradient_container.dart';
import 'package:coffee_app/features/authentication/presentation/view/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/bloc/auth_bloc.dart';
import 'widgets/signup_view_body.dart';

class AuthenticationView extends StatelessWidget {
  AuthenticationView({super.key});

  final ValueNotifier<bool> login = ValueNotifier(false);

  void toggleAuthMode() {
    login.value = !login.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GradientContainer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: BlocProvider(
                create: (context) => AuthBloc(),
                child: ValueListenableBuilder(
                  valueListenable: login,
                  builder: (context, value, child) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: login.value
                          ? LoginViewBody(toggleAuthMode: toggleAuthMode)
                          : SignupViewBody(toggleAuthMode: toggleAuthMode),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

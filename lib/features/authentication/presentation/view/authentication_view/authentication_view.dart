import 'package:coffee_app/core/widgets/custom_container.dart';
import 'package:coffee_app/core/widgets/fade_scale_switcher.dart';
import 'package:coffee_app/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:coffee_app/features/authentication/presentation/view/authentication_view/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/signup_view_body.dart';

class AuthenticationView extends StatelessWidget {
  AuthenticationView({super.key});

  final ValueNotifier<bool> login = ValueNotifier(true);

  void toggleAuthMode() {
    login.value = !login.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomContainer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 58),
              child: BlocProvider(
                create: (context) => AuthBloc(),
                child: ValueListenableBuilder(
                  valueListenable: login,
                  builder: (context, value, child) {
                    return FadeScaleSwitcher(
                      duration: const Duration(milliseconds: 200),
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

import 'dart:async';

import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/widgets/custom_container.dart';
import 'package:coffee_app/core/widgets/fade_scale_switcher.dart';
import 'package:coffee_app/features/authentication/presentation/view/authentication_view/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'widgets/signup_view_body.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  final ValueNotifier<bool> login = ValueNotifier(true);
  late final StreamSubscription<AuthState> _authSubscription;
  String? signupEmail;
  @override
  void initState() {
    super.initState();
    _resetPasswordLinkHandler();
  }

  void _resetPasswordLinkHandler() {
    _authSubscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (event) {
        if (!mounted) return;
        final type = event.event;
        if (type == AuthChangeEvent.passwordRecovery) {
          GoRouter.of(context).push(AppRouter.kResetPassword);
        }
      },
      onError: (error) {
        if (!mounted) return;
        UiHelpers.showSnackBar(
          context: context,
          message: Failure.fromException(error).error,
        );
      },
    );
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    login.dispose();
    super.dispose();
  }

  void toggleAuthMode({String? email}) {
    signupEmail = email;
    login.value = !login.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: CustomContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 58),
              child: ValueListenableBuilder(
                valueListenable: login,
                builder: (context, value, child) {
                  return FadeScaleSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: login.value
                        ? LoginViewBody(
                            toggleAuthMode: toggleAuthMode,
                            email: signupEmail,
                          )
                        : SignupViewBody(toggleAuthMode: toggleAuthMode),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:coffee_app/core/widgets/custom_container.dart';
import 'package:coffee_app/core/widgets/fade_scale_switcher.dart';
import 'package:coffee_app/features/authentication/presentation/view/forgot_password_view/widgets/change_password_view_body.dart';
import 'package:coffee_app/features/authentication/presentation/view/forgot_password_view/widgets/send_email_view_body.dart';
import 'package:coffee_app/features/authentication/presentation/view/forgot_password_view/widgets/verify_email_view_body.dart';
import 'package:flutter/material.dart';

enum ForgotPasswordState { sendEmail, verify, resetPassword }

final ValueNotifier<ForgotPasswordState> stateNotifier = ValueNotifier(
  ForgotPasswordState.sendEmail,
);

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key, this.sta});
  static String? email;
  final ForgotPasswordState? sta;

  @override
  Widget build(BuildContext context) {
    void onStateChange(ForgotPasswordState state) {
      stateNotifier.value = state;
    }

    onStateChange(sta ?? ForgotPasswordState.sendEmail);
    return Scaffold(
      body: SingleChildScrollView(
        child: CustomContainer(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ValueListenableBuilder<ForgotPasswordState>(
                valueListenable: stateNotifier,
                builder: (context, value, child) {
                  return FadeScaleSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: switch (value) {
                      ForgotPasswordState.sendEmail => SendEmailViewBody(
                        onStateChange: onStateChange,
                      ),
                      ForgotPasswordState.verify => VerifyEmailViewBody(
                        onStateChange: onStateChange,
                        email: ForgotPasswordView.email ?? "",
                      ),
                      ForgotPasswordState.resetPassword =>
                        const ChangePasswordViewBody(),
                    },
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

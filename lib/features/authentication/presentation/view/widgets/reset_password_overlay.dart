import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/overlay_container.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/helper/ui_helpers.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../generated/l10n.dart';

class ResetPasswordOverlay extends StatefulWidget {
  const ResetPasswordOverlay({super.key});

  @override
  State<ResetPasswordOverlay> createState() => _ResetPasswordOverlayState();
}

class _ResetPasswordOverlayState extends State<ResetPasswordOverlay> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final RegExp _emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text("Reset Password"),
            Form(
              key: formKey,
              child: TextFormField(
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
            ),
            CustomElevatedButton(
              onPressed: () {
                formKey.currentState!.validate();
              },
              child: Text(
                "Send Email",
                style: TextStyles.medium20.copyWith(
                  color: context.colors.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void resetPasswordOverlay(BuildContext context) =>
    UiHelpers.showOverlay(context: context, child: ResetPasswordOverlay());

import 'package:coffee_app/features/authentication/presentation/view/widgets/Signup_form.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import 'auth_suggestion.dart';
import 'auth_title.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key, required this.toggleAuthMode});
  final VoidCallback toggleAuthMode;

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTitle(
          title: S.current.get_started_title,
          subtitle: S.current.get_started_subtitle,
        ),
        const SizedBox(height: 48),
        const SignupForm(),
        const SizedBox(height: 48),
        CustomElevatedButton(
          onPressed: () {},
          child: Text(S.current.sign_up, style: TextStyles.medium20),
        ),
        const Spacer(),
        AuthSuggestion(
          toggleAuthMode: widget.toggleAuthMode,
          suggestionText: S.current.already_have_account,
          actionText: S.current.log_in,
        ),
      ],
    );
  }
}

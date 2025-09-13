import 'package:coffee_app/core/constants/reg_constants.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:coffee_app/features/authentication/presentation/view/forgot_password_view/forgot_password_view.dart';
import 'package:coffee_app/features/authentication/presentation/view/widgets/auth_title.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class SendEmailViewBody extends StatefulWidget {
  const SendEmailViewBody({super.key, required this.onStateChange});
  final void Function(ForgotPasswordState state) onStateChange;

  @override
  State<SendEmailViewBody> createState() => _SendEmailViewBodyState();
}

class _SendEmailViewBodyState extends State<SendEmailViewBody> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 48,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomAppBar(
          leading: CustomIconButton(
            padding: 8,
            onPressed: () {
              widget.onStateChange(ForgotPasswordState.sendEmail);
              GoRouter.of(context).pop();
            },
            child: Icon(
              Ionicons.chevron_back,
              color: context.colors.onSecondary,
            ),
          ),
        ),

        const AuthTitle(
          title: "Reset password",
          subtitle: "Enter your email to reset your password.",
        ),
        Form(
          key: _formKey,
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
              } else if (!RegConstants.emailRegExp.hasMatch(value.trim())) {
                return S.current.invalidEmail;
              }
              return null;
            },
          ),
        ),
        CustomElevatedButton(
          child: Text(
            S.current.log_in,
            style: TextStyles.medium20.copyWith(
              color: context.colors.onPrimary,
            ),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              BlocProvider.of<AuthBloc>(
                context,
              ).add(ResetPasswordEvent(email: emailController.text));
              widget.onStateChange(ForgotPasswordState.verify);
            }
          },
        ),
      ],
    );
  }
}

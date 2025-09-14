import 'package:coffee_app/core/helper/ui_helpers.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pinput/pinput.dart';

class VerifyEmailViewBody extends StatefulWidget {
  const VerifyEmailViewBody({
    super.key,
    required this.onStateChange,
    required this.email,
  });

  final void Function(ForgotPasswordState state) onStateChange;
  final String email;
  @override
  State<VerifyEmailViewBody> createState() => _VerifyEmailViewBodyState();
}

class _VerifyEmailViewBodyState extends State<VerifyEmailViewBody> {
  final TextEditingController tokenController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    tokenController.dispose();
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
            onPressed: () =>
                widget.onStateChange(ForgotPasswordState.sendEmail),
            child: Icon(
              Ionicons.chevron_back,
              color: context.colors.onSecondary,
            ),
          ),
        ),

        const AuthTitle(
          title: "Enter Verification Code",
          subtitle:
              "Enter the 6-digit verification code we sent to your email.",
        ),
        Form(
          key: _formKey,
          child: Pinput(
            controller: tokenController,
            length: 6,
            separatorBuilder: (index) => const SizedBox(width: 16),
            defaultPinTheme: PinTheme(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: context.colors.secondary,
              ),
            ),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the code';
              }
              if (value.length < 6) {
                return 'Code must be 6 digits';
              }
              return null; // valid
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),

        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              UiHelpers.showSnackBar(context: context, message: state.error);
            } else if (state is AuthVerifySuccess) {
              UiHelpers.showSnackBar(
                context: context,
                message: "Your Token Is Matched",
              );
            }
            widget.onStateChange(ForgotPasswordState.resetPassword);
          },
          builder: (context, state) {
            return CustomElevatedButton(
              child: state is AuthforgotPasswordLoading
                  ? SpinKitThreeBounce(
                      color: context.colors.onPrimary,
                      size: 26,
                    )
                  : Text(
                      S.current.log_in,
                      style: TextStyles.medium20.copyWith(
                        color: context.colors.onPrimary,
                      ),
                    ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<AuthBloc>(context).add(
                    VerifyEmailEvent(
                      token: tokenController.text,
                      email: widget.email,
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}

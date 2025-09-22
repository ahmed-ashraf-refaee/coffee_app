import 'dart:async';

import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:coffee_app/features/authentication/presentation/view/forgot_password_view/forgot_password_view.dart';
import 'package:coffee_app/features/authentication/presentation/view/widgets/auth_title.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final ValueNotifier<int> seconds = ValueNotifier<int>(59);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    _timer?.cancel();
    seconds.value = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    seconds.dispose();
    _timer?.cancel();
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

        AuthTitle(
          title: S.current.enterVerificationCode,
          subtitle: S.current.enterVerificationCodeSubtitle,
        ),
        Form(
          key: _formKey,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              controller: tokenController,
              length: 6,
              separatorBuilder: (index) => const SizedBox(width: 16),
              defaultPinTheme: PinTheme(
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.colors.secondary,
                ),
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.current.pleaseEnterCode;
                }
                if (value.length < 6) {
                  return S.current.codeMustBeSixDigits;
                }
                return null;
              },
              onCompleted: (value) {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<AuthBloc>(
                    context,
                  ).add(VerifyEmailEvent(token: value, email: widget.email));
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
              errorBuilder: (errorText, pin) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    errorText ?? '',
                    style: TextStyles.bold14.copyWith(
                      color: context.colors.primary.withValues(alpha: 0.8),
                    ),
                  ),
                );
              },
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ),
        Row(
          spacing: 8,
          children: [
            Text(
              S.current.notReceivedYet,
              style: TextStyles.bold14.copyWith(
                color: context.colors.onSecondary.withAlpha(153),
              ),
              textAlign: TextAlign.center,
            ),
            ValueListenableBuilder(
              valueListenable: seconds,
              builder: (context, value, _) {
                return value > 0
                    ? Text(
                        S.current.resendAfterSeconds(value),
                        style: TextStyles.bold14.copyWith(
                          color: context.colors.onSecondary.withValues(
                            alpha: 0.75,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )
                    : PrettierTap(
                        child: Text(
                          S.current.resendCode,
                          style: TextStyles.bold14.copyWith(
                            color: context.colors.primary.withValues(
                              alpha: 0.8,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          startCountdown();
                          BlocProvider.of<AuthBloc>(context).add(
                            ResetPasswordEvent(
                              email: ForgotPasswordView.email!,
                            ),
                          );
                        },
                      );
              },
            ),
          ],
        ),
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              UiHelpers.showSnackBar(context: context, message: state.error);
            } else if (state is AuthVerifySuccess) {
              UiHelpers.showSnackBar(
                context: context,
                message: S.current.verificationSuccessful,
              );
              widget.onStateChange(ForgotPasswordState.resetPassword);
            } else if (state is AuthCheckMailSuccess) {
              UiHelpers.showSnackBar(
                context: context,
                message: S.current.newCodeSent,
              );
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is AuthLoading,

              child: Text(
                S.current.verify,
                style: TextStyles.medium20
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  BlocProvider.of<AuthBloc>(context).add(
                    VerifyEmailEvent(
                      token: tokenController.text,
                      email: widget.email,
                    ),
                  );
                } else {
                  FocusScope.of(context).unfocus();
                }
              },
            );
          },
        ),
      ],
    );
  }
}

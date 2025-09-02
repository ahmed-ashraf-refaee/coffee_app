import 'package:coffee_app/features/authentication/presentation/manager/bloc/auth_bloc.dart';
import 'package:coffee_app/features/authentication/presentation/view/widgets/build_suffix_icon_with_divider.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/widgets/animated_icon_switch.dart';

class SignupForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  SignupForm({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier(false);
  static final RegExp _nameRegExp = RegExp(r"^[\p{L}'-.]+$", unicode: true);

  static final RegExp _emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$',
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Expanded(
                child: TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(
                    hintText: S.current.first_name,
                    prefixIcon: const Icon(Ionicons.person_outline),
                  ),
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return S.current.enterFirstName;
                    } else if (value.trim().length < 3) {
                      return S.current.tooShort;
                    } else if (value.trim().length > 20) {
                      return S.current.tooLong;
                    } else if (!_nameRegExp.hasMatch(value.trim())) {
                      return S.current.invalidCharacters;
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: S.current.last_name,
                    prefixIcon: const Icon(Ionicons.person_outline),
                  ),
                  autovalidateMode: AutovalidateMode.onUnfocus,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return S.current.enterLastName;
                    } else if (value.trim().length < 3) {
                      return S.current.tooShort;
                    } else if (value.trim().length > 20) {
                      return S.current.tooLong;
                    } else if (!_nameRegExp.hasMatch(value.trim())) {
                      return S.current.invalidCharacters;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              bool isUsernameTaken = false;
              if (state is AuthUsernameSuccess) {
                isUsernameTaken = state.usernameCheck;
              }

              return TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: S.current.username,
                  prefixIcon: const Icon(Ionicons.person_outline),
                  suffixIcon: state is AuthLoading
                      ? const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      : null,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return S.current.enterUsername;
                  } else if (value.trim().length < 3) {
                    return S.current.tooShort;
                  } else if (value.trim().length > 30) {
                    return S.current.tooLong;
                  } else if (isUsernameTaken) {
                    return S.current.usernameTaken;
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.trim().isNotEmpty && value.trim().length >= 2) {
                    BlocProvider.of<AuthBloc>(
                      context,
                    ).add(UsernameCheckEvent(username: value.trim()));
                  }
                },
              );
            },
          ),
          TextFormField(
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
          ValueListenableBuilder(
            valueListenable: _isPasswordVisible,
            builder: (context, value, child) {
              return TextFormField(
                controller: passwordController,
                obscureText: !value,
                decoration: InputDecoration(
                  hintText: S.current.password,
                  prefixIcon: const Icon(Ionicons.lock_closed_outline),
                  suffixIcon: buildSuffixIconWithDivider(
                    context,
                    AnimatedIconSwitch(
                      children: const [
                        Icon(Ionicons.eye_off_outline),
                        Icon(Ionicons.eye),
                      ],
                      onChanged: (value) {
                        _isPasswordVisible.value = value;
                      },
                    ),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.current.enterPassword;
                  }
                  if (value.length < 8) {
                    return S.current.minPassword;
                  }
                  if (!_passwordRegExp.hasMatch(value)) {
                    return S.current.passwordRequirement;
                  }
                  return null;
                },
              );
            },
          ),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: S.current.confirm_password,
              prefixIcon: const Icon(Ionicons.lock_closed_outline),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.current.confirmPassword;
              } else if (value != passwordController.text) {
                return S.current.passwordsDontMatch;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

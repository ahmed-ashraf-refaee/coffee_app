import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helper/ui_helpers.dart';
import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../manager/edit_profile/edit_profile_cubit.dart';

class SaveProfileButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final File? imageFile;

  const SaveProfileButton({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileFailure) {
          UiHelpers.showSnackBar(context: context, message: state.error);
        } else if (state is EditProfileSuccess) {
          UiHelpers.showSnackBar(
            context: context,
            message: S.current.profileUpdatedSuccessfully,
          );
          context.read<EditProfileCubit>().fetchUserData();
          GoRouter.of(context).pop();
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          disabled: state is FetchProfileLoadingState,
          isLoading: state is EditProfileLoading,
          onPressed: () => _onTapSave(context),
          child: Text(S.current.save, style: TextStyles.medium20),
        );
      },
    );
  }

  void _onTapSave(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<EditProfileCubit>().editProfileData(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        userName: usernameController.text,
        imageFile: imageFile,
      );
    }
  }
}

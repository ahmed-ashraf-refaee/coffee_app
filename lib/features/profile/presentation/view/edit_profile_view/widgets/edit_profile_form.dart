import 'dart:io';

import 'package:coffee_app/features/authentication/data/model/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../manager/edit_profile/edit_profile_cubit.dart';
import 'profile_form_fields.dart';
import 'profile_image_picker.dart';
import 'profile_info_display.dart';

class EditProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController usernameController;
  final File? imageFile;
  final Function(File?) onImagePicked;

  const EditProfileForm({
    super.key,
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.usernameController,
    required this.imageFile,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (_, state) =>
          state is FetchProfileSuccessState ||
          state is FetchProfileFailureState,
      builder: (context, state) {
        UserProfileModel? user;
        if (state is FetchProfileSuccessState) {
          user = state.userProfileModel;
          firstNameController.text = user.firstName;
          lastNameController.text = user.lastName;
          usernameController.text = user.userName;
        }

        return Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 22),
              ProfileImagePicker(
                imageFile: imageFile,
                profileImageUrl: user?.profileImageUrl,
                onImagePicked: onImagePicked,
              ),
              const SizedBox(height: 22),
              ProfileInfoDisplay(
                firstName: user?.firstName ?? '',
                lastName: user?.lastName ?? '',
                email: user?.email ?? '',
              ),
              const SizedBox(height: 22),
              ProfileFormFields(
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                usernameController: usernameController,
              ),
            ],
          ),
        );
      },
    );
  }
}

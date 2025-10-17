import 'dart:io';

import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../core/widgets/prettier_tap.dart';
import '../profile_view/widgets/profile_divider.dart';
import 'widgets/edit_profile_form.dart';
import 'widgets/edit_profile_tiles.dart';
import 'widgets/save_profile_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  File? imageFile;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      CustomAppBar(
                        leading: PrettierTap(
                          onPressed: () {},
                          child: CustomIconButton(
                            padding: 8,
                            onPressed: () => GoRouter.of(context).pop(),
                            child: Icon(
                              context.isArabic
                                  ? Ionicons.chevron_forward
                                  : Ionicons.chevron_back,
                              color: context.colors.onSecondary,
                            ),
                          ),
                        ),
                      ),
                      EditProfileForm(
                        formKey: _formKey,
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        usernameController: usernameController,
                        imageFile: imageFile,
                        onImagePicked: (File? file) {
                          setState(() {
                            imageFile = file;
                          });
                        },
                      ),
                      const ProfileDivider(intend: 0),
                      const ChangeEmailTile(),
                      const ChangePasswordTile(),
                    ],
                  ),
                ),
              ),
              SaveProfileButton(
                formKey: _formKey,
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                usernameController: usernameController,
                imageFile: imageFile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

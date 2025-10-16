import 'dart:io';

import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/features/authentication/data/model/user_profile_model.dart';
import 'package:coffee_app/features/profile/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/utils/app_router.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../core/widgets/custom_rounded_images.dart';
import '../../../../../core/widgets/prettier_tap.dart';
import '../profile_view/widgets/profile_container.dart';
import '../profile_view/widgets/profile_divider.dart';
import '../profile_view/widgets/profile_tile.dart';

class EditProfileView extends StatefulWidget {
  final UserProfileModel user;

  const EditProfileView({super.key, required this.user});

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
    firstNameController.text = widget.user.firstName;
    lastNameController.text = widget.user.lastName;
    usernameController.text = widget.user.userName;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
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
                    Form(
                      key: _formKey,
                      child: Column(
                        spacing: 22,
                        children: [
                          Stack(
                            fit: StackFit.loose,
                            alignment: Alignment.center,
                            children: [
                              imageFile != null
                                  ? Hero(
                                      tag: widget.user.profileImageUrl!,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.file(
                                          imageFile!,
                                          fit: BoxFit.cover,
                                          width: 170,
                                          height: 170,
                                          filterQuality: FilterQuality.low,
                                        ),
                                      ),
                                    )
                                  : widget.user.profileImageUrl != null
                                  ? Hero(
                                      tag: widget.user.profileImageUrl!,
                                      child: CustomRoundedImage(
                                        imageUrl: widget.user.profileImageUrl!,
                                        aspectRatio: 1,
                                        width: 170,
                                      ),
                                    )
                                  : const CustomRoundedImage(
                                      imageUrl: "assets/icons/user.png",
                                      isAsset: true,
                                      aspectRatio: 1,
                                      width: 170,
                                    ),

                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CustomIconButton(
                                  padding: 4,
                                  width: 36,
                                  hight: 36,
                                  backgroundColor: context.colors.secondary
                                      .withValues(alpha: 0.65),
                                  onPressed: _pickImage,
                                  child: Icon(
                                    Ionicons.camera_outline,
                                    color: context.colors.onSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                '${widget.user.firstName} ${widget.user.lastName}',
                                style: TextStyles.bold20,
                              ),
                              Text(
                                widget.user.email,
                                style: TextStyles.medium12.copyWith(
                                  color: context.colors.onSecondary,
                                ),
                              ),
                            ],
                          ),
                          _buildFormSection(context),
                          const ProfileDivider(intend: 0),
                          ProfileContainer(
                            child: PrettierTap(
                              shrink: 1,
                              onPressed: () {
                                GoRouter.of(
                                  context,
                                ).push(AppRouter.kChangeEmailView);
                              },
                              child: ProfileTile(
                                prefixIcon: "assets/icons/email.png",
                                title: "Change Email",
                                suffixWidget: context.isArabic
                                    ? Icon(
                                        Ionicons.chevron_back,
                                        color: context.colors.onSecondary,
                                      )
                                    : Icon(
                                        Ionicons.chevron_forward,
                                        color: context.colors.onSecondary,
                                      ),
                              ),
                            ),
                          ),
                          ProfileContainer(
                            child: PrettierTap(
                              shrink: 1,
                              onPressed: () {
                                GoRouter.of(
                                  context,
                                ).push(AppRouter.kChangePassword);
                              },
                              child: ProfileTile(
                                prefixIcon: "assets/icons/change_password.png",
                                title: "Change Password",
                                suffixWidget: context.isArabic
                                    ? Icon(
                                        Ionicons.chevron_back,
                                        color: context.colors.onSecondary,
                                      )
                                    : Icon(
                                        Ionicons.chevron_forward,
                                        color: context.colors.onSecondary,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _buildBottomSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 16,
          children: [
            Expanded(
              child: _buildTextField(
                label: 'First Name',
                controller: firstNameController,
                validator: _validateFirstName,
                icon: const Icon(Ionicons.person_outline),
              ),
            ),
            Expanded(
              child: _buildTextField(
                label: 'Last Name',
                controller: lastNameController,
                validator: _validateLastName,
                icon: const Icon(Ionicons.person_outline),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Username',
          controller: usernameController,
          validator: _validateUsername,
          icon: const Icon(Ionicons.person_outline),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    Icon? icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: label, prefixIcon: icon),
      autovalidateMode: AutovalidateMode.onUnfocus,

      validator: validator,
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileFailure) {
          UiHelpers.showSnackBar(context: context, message: state.error);
        } else if (state is EditProfileSuccess) {
          UiHelpers.showSnackBar(
            context: context,
            message: "Profile updated successfully",
          );
          context.read<EditProfileCubit>().fetchUserData();
          GoRouter.of(context).pop();
        }
      },
      builder: (context, state) {
        return CustomElevatedButton(
          isLoading: state is EditProfileLoading,
          onPressed: () => _onTapSave(context),
          child: const Text("Save", style: TextStyles.medium20),
        );
      },
    );
  }

  // Validation
  String? _validateFirstName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter first name';
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.isEmpty) return 'Please enter last name';
    return null;
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Please enter username';
    if (value.length < 3) return 'Username must be at least 3 characters';
    return null;
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _onTapSave(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<EditProfileCubit>().editProfileData(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        userName: usernameController.text,
        imageFile: imageFile,
      );
    }
  }
}

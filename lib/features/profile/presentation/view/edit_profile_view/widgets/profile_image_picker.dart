import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../../core/widgets/custom_rounded_images.dart';
import '../../../../../../main.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? imageFile;
  final String? profileImageUrl;
  final ValueChanged<File?> onImagePicked;

  const ProfileImagePicker({
    super.key,
    required this.imageFile,
    required this.profileImageUrl,
    required this.onImagePicked,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                  width: 170,
                  height: 170,
                  filterQuality: FilterQuality.low,
                ),
              )
            : profileImageUrl != null
            ? Hero(
                tag: profileImageUrl!,
                child: CustomRoundedImage(
                  imageUrl: profileImageUrl!,
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
            backgroundColor: context.colors.secondary.withValues(alpha: 0.65),
            onPressed: () => _pickImage(context),
            child: Icon(
              Ionicons.camera_outline,
              color: context.colors.onSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }
}

import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../../core/widgets/custom_icon_button.dart';

class EditProfileImageSection extends StatelessWidget {
  const EditProfileImageSection({super.key, this.imageUrl});
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.center,
      children: [
        imageUrl != null
            ? Hero(
                tag: imageUrl!,
                child: CustomRoundedImage(
                  imageUrl: imageUrl!,
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
            onPressed: () {},
            child: Icon(
              Ionicons.camera_outline,
              color: context.colors.onSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

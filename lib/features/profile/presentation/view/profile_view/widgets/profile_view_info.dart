import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/custom_rounded_images.dart';
import 'profile_container.dart';

class ProfileViewBodyInfoSection extends StatelessWidget {
  const ProfileViewBodyInfoSection({super.key});
  final String? imageUrl =
      "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/1938_Portrait_of_Adolf_Hitler_Official_Nazi_Party_handbook_%28cropped%29.jpg/120px-1938_Portrait_of_Adolf_Hitler_Official_Nazi_Party_handbook_%28cropped%29.jpg";
  @override
  Widget build(BuildContext context) {
    return ProfileContainer(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: imageUrl != null
                ? Hero(
                    tag: imageUrl!,
                    child: CustomRoundedImage(
                      imageUrl: imageUrl!,
                      aspectRatio: 1,
                      width: 80,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )
                : CustomRoundedImage(
                    imageUrl: "assets/icons/user.png",
                    isAsset: true,
                    aspectRatio: 1,
                    width: 80,
                    borderRadius: BorderRadius.circular(8),
                  ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sameh Khalil",
                style: TextStyles.medium20.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "sameh.eldegwy@gmail.com",
                style: TextStyles.medium12.copyWith(
                  color: context.colors.onSecondary,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../../../core/utils/color_palette.dart';
import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../core/widgets/custom_rounded_images.dart';
import 'profile_container.dart';

class ProfileInfoSection extends StatelessWidget {
  const ProfileInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ProfileContainer(
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 6, top: 6, bottom: 6, right: 14),
              child: CustomRoundedImage(
                imageUrl:
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/1938_Portrait_of_Adolf_Hitler_Official_Nazi_Party_handbook_%28cropped%29.jpg/120px-1938_Portrait_of_Adolf_Hitler_Official_Nazi_Party_handbook_%28cropped%29.jpg",
                aspectRatio: 1,
                width: 80,
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
                    color: ColorPalette.cadetGray,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

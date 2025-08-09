import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CustomIconButton(
                  onPressed: () {},
                  child: Image.asset("assets/icons/arrow.png", height: 24),
                ),
              ),

              Container(
                width: context.width,
                decoration: BoxDecoration(
                  color: ColorPalette.raisinBlack,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                        top: 6,
                        bottom: 6,
                        right: 14,
                      ),
                      child: CustomRoundedImage(
                        imageUrl: null,
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
              Text("Profile Screen"),
            ],
          ),
        ),
      ),
    );
  }
}

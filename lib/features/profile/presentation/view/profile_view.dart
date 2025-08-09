import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/text_styles.dart';
import 'widgets/profile_container.dart';
import 'widgets/profile_tile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
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

              ProfileGroupContainer(
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
                        imageUrl: "",
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
              SizedBox(height: 48),
              ProfileGroupContainer(
                child: Column(
                  children: [
                    ProfileTile(
                      prefixIcon: "assets/icons/user_icon.png",
                      title: 'Edit Profile',
                      suffixWidget: Image.asset(
                        "assets/icons/arrow_forward.png",
                        height: 24,
                        color: ColorPalette.cadetGray,
                      ),
                    ),
                    _profileTileDivider(),
                    ProfileTile(
                      prefixIcon: "assets/icons/credit_card.png",
                      title: 'Payment Details',
                      suffixWidget: Image.asset(
                        "assets/icons/arrow_forward.png",
                        height: 24,
                        color: ColorPalette.cadetGray,
                      ),
                    ),
                    _profileTileDivider(),
                    ProfileTile(
                      prefixIcon: "assets/icons/arabic.png",
                      title: 'Languages',
                      suffixWidget: Image.asset(
                        "assets/icons/arrow_forward.png",
                        height: 24,
                        color: ColorPalette.cadetGray,
                      ),
                    ),
                    _profileTileDivider(),
                    ProfileTile(
                      prefixIcon: "assets/icons/bell.png",
                      title: 'Notification',
                      suffixWidget: SizedBox(
                        height: 42,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Switch(value: false, onChanged: (value) {}),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    _profileTileDivider(),
                    ProfileTile(
                      prefixIcon: "assets/icons/night_mode.png",
                      title: 'Dark Mode',
                      suffixWidget: SizedBox(
                        height: 42,
                        child: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Switch(value: true, onChanged: (value) {}),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              ProfileGroupContainer(
                child: Column(
                  children: [
                    ProfileTile(
                      prefixIcon: "assets/icons/help.png",
                      title: "Support",
                      suffixWidget: Image.asset(
                        "assets/icons/arrow_forward.png",
                        height: 24,
                        color: ColorPalette.cadetGray,
                      ),
                    ),
                    _profileTileDivider(),
                    ProfileTile(
                      title: "Logout",
                      suffixWidget: Image.asset(
                        "assets/icons/logout.png",
                        height: 24,
                        color: ColorPalette.orangeCrayola,
                      ),
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 22),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Divider _profileTileDivider() {
    return Divider(
      color: Color(0xff5D6165).withAlpha((85 * 255 / 100).toInt()),
      indent: 16,
      endIndent: 16,
      thickness: 1,
    );
  }
}

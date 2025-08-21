import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_icon_button.dart';
import 'profile_view_body_settings.dart';
import 'profile_view_info.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: CustomIconButton(
                padding: 8,
                onPressed: () {},
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: context.colors.onSecondary.withAlpha(220),
                ),
              ),
            ),
            const ProfileViewBodyInfoSection(),
            const SizedBox(height: 48),
            const ProfileViewBodySettings(),
          ],
        ),
      ),
    );
  }
}

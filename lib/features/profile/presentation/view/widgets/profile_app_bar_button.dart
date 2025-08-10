import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_icon_button.dart';

class ProfileAppBarButton extends StatelessWidget {
  const ProfileAppBarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      sliver: SliverToBoxAdapter(
        child: Align(
          alignment: Alignment.centerLeft,
          child: CustomIconButton(
            onPressed: () {},

            child: Image.asset("assets/icons/arrow.png", height: 24),
          ),
        ),
      ),
    );
  }
}

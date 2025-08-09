import 'package:coffee_app/features/home/presentation/view/widgets/clipped_background_item_home_list.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/color_palette.dart';
import '../../../../core/widgets/custom_icon_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            ClipPath(
              clipper: ContainerClipper(),
              child: Container(
                width: 182,
                height: 244,
                decoration: BoxDecoration(
                  color: ColorPalette.cadetGray,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomIconButton(
                onPressed: () {},
                width: 34,
                hight: 34,
                backgroundColor: ColorPalette.orangeCrayola,
                foregroundColor: ColorPalette.antiFlashWhite,
                child: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:coffee_app/features/home/presentation/view/widgets/custom_home_list_item_clipper.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

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
              clipper: CustomHomeListItemClipper(
                clipHeight: 48,
                clipWidth: 48,
                radius: 12,
              ),
              child: Container(
                width: 182,
                height: 244,
                decoration: BoxDecoration(
                  color: context.colors.secondary,
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
                backgroundColor: context.colors.primary,
                padding: 8,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: context.colors.onSurface,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

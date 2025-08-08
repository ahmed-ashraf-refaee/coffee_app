import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../../../../core/utils/color_palette.dart';
import '../../manager/navigator_cubit/navigator_cubit.dart';
import 'bottom_nav_bar_item.dart';

class CustomButtomNavBar extends StatelessWidget {
  CustomButtomNavBar({super.key});

  final List<IconData> icons = [
    UniconsLine.home_alt,
    UniconsLine.shopping_bag,
    UniconsLine.heart_alt,
    Icons.person_outline_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    double calcDotPositioned() {
      var widthWithoutPadding = context.width - 32;
      var halfGapWidthWithoutIconSizes =
          (widthWithoutPadding - (icons.length * 24)) / (5 * 2);
      return halfGapWidthWithoutIconSizes;
    }

    return BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(icons.length, (index) {
                  return BottomNavBarItem(
                    icon: icons[index],
                    isSelected:
                        BlocProvider.of<AppNavigatorCubit>(
                          context,
                        ).currentIndex ==
                        index,
                    onPressed: () {
                      BlocProvider.of<AppNavigatorCubit>(
                        context,
                      ).setCurrentIndex(index);
                    },
                  );
                }),
              ),
              AnimatedSlide(
                duration: const Duration(milliseconds: 300),
                curve: Curves.decelerate,
                offset: Offset(
                  state is AppNavigatorToHomeView
                      ? -(calcDotPositioned() * 3 + 36) / 4
                      : state is AppNavigatorToCartView
                      ? -(calcDotPositioned() + 12) / 4
                      : state is AppNavigatorToWishlistView
                      ? (calcDotPositioned() + 12) / 4
                      : state is AppNavigatorToProfileView
                      ? (calcDotPositioned() * 3 + 36) / 4
                      : -(calcDotPositioned() * 3 + 36) / 4,
                  -2,
                ),
                child: Container(
                  width: 4,
                  height: 4,

                  decoration: BoxDecoration(
                    color: ColorPalette.orangeCrayola,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

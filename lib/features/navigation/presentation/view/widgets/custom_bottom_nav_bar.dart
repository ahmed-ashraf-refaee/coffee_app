import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../manager/navigator_cubit/navigator_cubit.dart';
import 'bottom_nav_bar_item.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final List<IconData> icons = [
    UniconsLine.home_alt,
    UniconsLine.shopping_bag,
    UniconsLine.heart_alt,
    Icons.person_outline_outlined,
  ];
  final double horizontalPadding = 16;
  final double verticalPadding = 16;

  @override
  Widget build(BuildContext context) {
    double calcDotOffset({
      required int index,
      required double iconSize,
      required double dotSize,
    }) {
      index++;
      double totalWidth = context.width - (horizontalPadding * 2);
      double spaceWidth = totalWidth - (icons.length * iconSize);
      double step = (spaceWidth / (icons.length + 1)) + iconSize;
      double offsetX =
          ((((step * index)) - (iconSize / 2)) - (dotSize / 2)) / dotSize;
      return context.isArabic ? -offsetX : offsetX;
    }

    return BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  calcDotOffset(
                    index: context.read<AppNavigatorCubit>().currentIndex,
                    iconSize: 24,
                    dotSize: 4,
                  ),
                  -2,
                ),
                child: Container(
                  width: 4,
                  height: 4,

                  decoration: BoxDecoration(
                    color: context.colors.primary,
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

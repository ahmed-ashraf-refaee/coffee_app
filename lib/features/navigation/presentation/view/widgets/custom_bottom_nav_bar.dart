import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../manager/navigator_cubit/navigator_cubit.dart';
import 'bottom_nav_bar_item.dart';

class Pair<T1, T2> {
  final T1 a;
  final T2 b;

  Pair(this.a, this.b);
}

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({super.key});

  final List<Pair<IconData, IconData>> icons = [
    Pair(Ionicons.home_outline, Ionicons.home),
    Pair(Ionicons.bag_outline, Ionicons.bag),
    Pair(Ionicons.heart_outline, Ionicons.heart),
    Pair(Ionicons.person_outline, Ionicons.person),
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
          padding: EdgeInsets.only(
            top: verticalPadding,
            bottom: verticalPadding,
            left: horizontalPadding,
            right: horizontalPadding,
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
                    iconSize: 48,
                    dotSize: 4,
                  ),
                  -2,
                ),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    shape: BoxShape.circle,
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

import 'package:coffee_app/core/utils/color_palette.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int currentIndex = 0;
  final List<Widget> screens = [
    Center(child: Text("Home Screen")),
    Center(child: Text("Cart Screen")),
    Center(child: Text("Favourite Screen")),
    Center(child: Text("Profile Screen")),
  ];

  final List<IconData> icons = [
    Icons.home_filled,
    Icons.shopping_bag_outlined,
    Icons.favorite_outline,
    Icons.person,
  ];

  double calcDotPositioned() {
    var widthWithoutPadding = context.width - 32;
    var halfGapWidthWithoutIconSizes =
        (widthWithoutPadding - (icons.length * 24)) / (5 * 2);
    return halfGapWidthWithoutIconSizes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(icons.length, (index) {
                return BottomNavItem(
                  icon: icons[index],
                  isSelected: currentIndex == index,
                  onPressed: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                );
              }),
            ),
            AnimatedSlide(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              offset: Offset(
                currentIndex == 0
                    ? -(calcDotPositioned() * 3 + 36) / 24
                    : currentIndex == 1
                    ? -(calcDotPositioned() + 12) / 24
                    : currentIndex == 2
                    ? (calcDotPositioned() + 12) / 24
                    : (calcDotPositioned() * 3 + 36) / 24,
                -2,
              ),
              child: Container(
                width: 24,
                height: 4,

                decoration: BoxDecoration(
                  color: ColorPalette.orangeCrayola,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatefulWidget {
  const BottomNavItem({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.isSelected,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final bool isSelected;

  @override
  State<BottomNavItem> createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<BottomNavItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onPressed,
            child: Icon(
              widget.icon,
              size: 24,
              color: widget.isSelected
                  ? ColorPalette.orangeCrayola
                  : ColorPalette.cadetGray,
            ),
          ),
        ],
      ),
    );
  }
}
